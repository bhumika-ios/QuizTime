//
//  ConclusionView.swift
//  QuizTime
//
//  Created by Bhumika Patel on 18/04/23.
//

import SwiftUI

extension Views {
    struct ConclusionView: View {
        @ObservedObject var viewModel: ViewModel
        @State var loadingProgress: Int = 0

        var body: some View {
            ZStack{
                Color("bg1").opacity(0.1)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ZStack {
                        Circle()
                            .trim(from: Views.ConclusionView.CircleConstant.trimBegin,
                                  to: Views.ConclusionView.CircleConstant.trimTarget)
                            .stroke(Color.red,
                                    style: StrokeStyle(lineWidth: Views.ConclusionView.CircleConstant.defaultLineWidth))
                            .frame(width: Views.ConclusionView.CircleConstant.frameSize,
                                   height: Views.ConclusionView.CircleConstant.frameSize)
                            .rotationEffect((Angle(degrees: Views.ConclusionView.CircleConstant.defaultAngle)))
                        Circle()
                            .trim(from: Views.ConclusionView.CircleConstant.trimBegin,
                                  to: Views.ConclusionView.CircleConstant.animatedTrimTarget(target: loadingProgress))
                            .stroke(Color.blue, lineWidth: Views.ConclusionView.CircleConstant.defaultLineWidth)
                            .frame(width: Views.ConclusionView.CircleConstant.frameSize,
                                   height: Views.ConclusionView.CircleConstant.frameSize)
                            .rotationEffect(Angle(degrees: Views.ConclusionView.CircleConstant.defaultAngle))
                        Text("\(viewModel.answerRate())%")
                            .font(.system(size: 32))
                            .fontWeight(.semibold)
                    }
                    .offset(y: 48)
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.white)
                            .frame(width: 350, height: 180)
                    }
                    .padding(10)
                    VStack(spacing: DesignSystem.Padding.microPadding) {
                        Text("Finished Quiz")
                            .foregroundColor(.blue)
                        List{
                            Section{
                                HStack{
                                    Text("Correct Answers:")
                                    Spacer()
                                    Text("\(viewModel.correctAnswers)")
                                }
                                HStack{
                                    Text("Incorrect Answers:")
                                    Spacer()
                                    Text("\(viewModel.wrongAnswers)")
                                }
                                HStack{
                                    Text("Total Questions Answers:")
                                    Spacer()
                                    Text("\(viewModel.totalQuestions)")
                                }
                              
                            }
                          
                            
                        }
                        VStack{
                            NavigationLink(destination: InitialView(viewModel: .init()).navigationBarHidden(true)) {
                                Text("Start Again")
                                    .foregroundColor(.white)
                            }
                        }
                        .background{
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.blue)
                                .frame(width: 350, height: 45)
                        }
                        .offset(y: -220)
                    }
                }.task {
                    animateCircle()
                }
            }
        }
        func animateCircle() {
            _ = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                withAnimation {
                    if loadingProgress < viewModel.answerRate() {
                        loadingProgress += 1
                        print(loadingProgress)
                    } else {
                        timer.invalidate()
                        return
                    }
                }
            }
        }
    }
}

extension Views.ConclusionView {
    struct CircleConstant {
        static let frameSize: CGFloat = 150
        static let trimBegin: CGFloat = 0.0
        static let trimTarget: CGFloat = 0.5
        static let defaultLineWidth: CGFloat = 12.0
        static let defaultAngle: CGFloat = 180
        static func animatedTrimTarget(target: Int) -> Double {
            return Double(target) / 100 / 2
        }
    }

    class ViewModel: ObservableObject {
        @Published var correctAnswers: Int = Manager.AnswerTracker.shared.correctAnswers
        @Published var wrongAnswers: Int = Manager.AnswerTracker.shared.wrongAnswers
        @Published var totalQuestions: Int = Manager.AnswerTracker.shared.questionAmount

        func answerRate() -> Int {
            var rate: Double
            rate = Double(correctAnswers) / Double(totalQuestions)
            return Int(rate*100)
        }
    }
}

