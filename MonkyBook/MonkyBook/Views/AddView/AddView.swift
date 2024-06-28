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
    @StateObject var vm = AddViewModel()
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 10) {
            
            HStack {
                Text("Nome do livro")
                    .padding(.horizontal)
                Spacer()
            }
            
            TextFieldBook(PlaceholderText: bookPlaceholderText, bookData: $vm.bookName)
            
            HStack {
                Text("Autor do livro")
                    .padding(.horizontal)
                Spacer()
            }
            TextFieldBook(PlaceholderText: authorPlaceholderText, bookData: $vm.authorName)
            
            Button(action: {
                vm.saveBook()
                dismiss()
            }, label: {
                RoundedRectangle(cornerRadius: 12)
                    .frame(width: 100, height: 50)
                    .overlay {
                        Text("Salvar")
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
