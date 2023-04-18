//
//  LaunchScreen.swift
//  QuizTime
//
//  Created by Bhumika Patel on 18/04/23.
//

import SwiftUI

struct LaunchScreen: View {
    var body: some View {
        ZStack{
            Color.white
                .opacity(0.9)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Constants.logoImage
                    .resizable()
                    .frame(width: Constants.logoImageSize, height: Constants.logoImageSize, alignment: .center)
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
