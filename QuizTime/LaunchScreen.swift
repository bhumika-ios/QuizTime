//
//  LaunchScreen.swift
//  QuizTime
//
//  Created by Bhumika Patel on 18/04/23.
//

import SwiftUI

struct LaunchScreen: View {
    @State var isLoading = true
    var body: some View {
        if isLoading {
            ZStack{
                Color.white
                    .opacity(0.9)
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Constants.logoImage
                        .resizable()
                        .frame(width: Constants.logoImageSize, height: Constants.logoImageSize, alignment: .center)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation {
                        self.isLoading = false
                        }
                    }
                }
            }
        } else {
            TabView {
                Views.InitialView(viewModel: .init())
                    .tabItem {
                        Label("Quiz", systemImage: "list.dash")
                    }
                Views.ProfileView(viewModel: .init())
                    .tabItem {
                        Label("Profile", systemImage: "person.circle.fill")
                    }
            }
        }
    }
    
}
extension LaunchScreen {
    struct Constants {
        static let logoImage: Image = .init("Bg1")
        static let logoImageSize: CGFloat = 300
        static let logoName: String = "SwitUI Quiz"
        static let fontSize: CGFloat = 40
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreen()
    }
}
