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
        VStack {
            TextField(bookPlaceholderText, text: $bookName)
                .font(.headline)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            TextField(authorPlaceholderText, text: $bookName)
                .font(.headline)
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            Button(action: {
                print("salve aqui")
            }, label: {
                Text("Save")
            })
        }
    }
}

#Preview {
    AddView()
}
