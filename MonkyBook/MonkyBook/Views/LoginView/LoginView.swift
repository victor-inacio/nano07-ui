//
//  LoginView.swift
//  MonkyBook
//
//  Created by Giovanni Favorin de Melo on 27/06/24.
//

import SwiftUI

struct LoginView: View {
    let bookPlaceholderText: String = ""
    let authorPlaceholderText: String = ""
    @State var bookName: String = ""
    @State var authorName: String = ""
    
    var body: some View {
        VStack(spacing: 10) {
            
            HStack {
                Text("Nome do usuário")
                    .padding(.horizontal)
                Spacer()
            }
            
            TextFieldBook(PlaceholderText: bookPlaceholderText, bookData: $bookName)
            
            HStack {
                Text("Senha")
                    .padding(.horizontal)
                Spacer()
            }
            TextFieldBook(PlaceholderText: authorPlaceholderText, bookData: $authorName)
            
            Button(action: {
                print("salve aqui")
            }, label: {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 100, height: 50)
                    .overlay {
                        Text("Logar")
                            .foregroundStyle(.white)
                    }
            })
            .padding()
            Spacer()
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 50, trailing: 10))
    }
}

#Preview {
    LoginView()
}
