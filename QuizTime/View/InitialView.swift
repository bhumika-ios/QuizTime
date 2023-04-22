//
//  InitialView.swift
//  QuizTime
//
//  Created by Bhumika Patel on 18/04/23.
//

import SwiftUI

extension Views {
    struct InitialView: View {
        @ObservedObject var viewModel: ViewModel
        let questionsViewModel: Views.QuestionView.ViewModel = .init()
        @State private var selectedDifficultyIndex = 0
        @State private var selectedCategoryIndex = 0
        @State private var selectedTypeIndex = 0

        var body: some View {
            NavigationView {
                ZStack{
                    List {
                        Section("Number of questions") {
                            Stepper {
                                Text("\(viewModel.numberQuestions)")
                            } onIncrement: { viewModel.numberQuestions += 1
                            } onDecrement: { viewModel.numberQuestions -= 1 }
                        }
                        
                        Section {
                            Picker(
                                selection: $selectedDifficultyIndex,
                                label: Text("Difficulty")
                            ) {
                                ForEach(0 ..< Manager.API.Difficulty.allCases.count, id: \.self) {
                                    Text(Manager.API.Difficulty.allCases[$0].rawValue.capitalizingFirstLetter())
                                }
                            }
                            
                            Picker(
                                selection: $selectedCategoryIndex,
                                label: Text("Category")
                            ) {
                                ForEach(0 ..< Manager.API.QuestionCategory.allCases.count, id: \.self) {
                                    Text(Manager.API.QuestionCategory.allCases[$0].categoryName)
                                }
                            }
                            
                            Picker(
                                selection: $selectedTypeIndex,
                                label: Text("Type")
                            ) {
                                ForEach(0 ..< Manager.API.AnswerTypes.allCases.count, id: \.self) {
                                    Text(Manager.API.AnswerTypes.allCases[$0].answerTypeName)
                                }
                                .padding()
                            }
                        }
                        
                        
                    }
                    VStack{
                        NavigationLink(destination: QuestionView(viewModel: questionsViewModel)
                                       
                            .navigationBarHidden(true)
                            .task {
                                do {
                                    Manager.AnswerTracker.shared.startQuiz(questionAmount: viewModel.numberQuestions)
                                    let questions = try await Manager.API.shared.fetchQuestions(
                                        category: Manager.API.QuestionCategory.allCases[selectedCategoryIndex],
                                        difficulty: Manager.API.Difficulty.allCases[selectedDifficultyIndex],
                                        answerType: Manager.API.AnswerTypes.allCases[selectedTypeIndex],
                                        amount: viewModel.numberQuestions
                                    )
                                    questionsViewModel.update(question: questions.first!)
                                } catch {
                                    print(error)
                                }
                            }
                                       
                        ){
                            
                            Text("Start")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                              
                        }
                        
                       
                    }
                    .background{
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.blue)
                            .frame(width: 350, height: 45)
                    }
                }
               
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true)
        }
    }
}

extension Views.InitialView {
    class ViewModel: ObservableObject {
        @Published var numberQuestions: Int = 5 {
            didSet {
                if numberQuestions == 0 {
                    numberQuestions = 1
                }

                if numberQuestions == 51 {
                    numberQuestions = 50
                }
            }
        }
    }
}

#if DEBUG
struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        Views.InitialView(viewModel: .init())
    }
}
#endif
