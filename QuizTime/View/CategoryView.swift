//
//  CategoryView.swift
//  QuizTime
//
//  Created by Bhumika Patel on 10/05/23.
//

import SwiftUI

struct CategoryView: View {
    let questionsViewModel: Views.QuestionView.ViewModel = .init()
    var body: some View {
        VStack(spacing: 15){
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                Button{
                    
                }label: {
                    Image(systemName: "person")
                        .resizable()
                        .frame(height: 250)
                        .cornerRadius(15)
                }
            }
            
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
