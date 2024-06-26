//
//  AddView.swift
//  MonkyBook
//
//  Created by Giovanni Favorin de Melo on 25/06/24.
//

import SwiftUI

struct AddView: View {
    let bookPlaceholderText: String = "Add book name here..."
    let authorPlaceholderText: String = "Add author's name here..."
    @State var bookName: String = ""
    @State var authorName: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                TextFieldBook(PlaceholderText: bookPlaceholderText, bookData: $bookName)
                
                TextFieldBook(PlaceholderText: authorPlaceholderText, bookData: $authorName)
                
                Button(action: {
                    print("salve aqui")
                }, label: {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 100, height: 50)
                        .overlay {
                            Text("Salvar")
                                .foregroundStyle(.white)
                        }
                })
            }
            .padding()
        }
    }
}

#Preview {
    AddView()
}

struct TextFieldBook: View {
    var PlaceholderText: String
    @Binding var bookData: String
    
    var body: some View {
        TextField(PlaceholderText, text: $bookData)
            .font(.headline)
            .padding()
            .background(.tertiary)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
