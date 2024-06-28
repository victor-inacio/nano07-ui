//
//  EditView.swift
//  MonkyBook
//
//  Created by Caio Marques on 27/06/24.
//

import SwiftUI

struct EditView: View {
    @Environment (\.dismiss) var dismiss
    @StateObject var vm = EditViewModel()
    let book : Book
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10){
            Text("Nome do livro: ")
                .bold()
            TextFieldBook(PlaceholderText: "Insert book name here", bookData: $vm.bookName)
            
            Text("Nome do autor: ")
                .bold()
            TextFieldBook(PlaceholderText: "Insert book name here", bookData: $vm.bookAuthor)
            
            Button {
                vm.editBook()
                dismiss()
            } label: {
                Text("Enviar")
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Spacer()
        }
        .onAppear(perform: {
            vm.setup(book)
        })
        .padding()
        .navigationTitle("Editar livro")
    }
}

#Preview {
    NavigationStack {
        EditView(book: Book(name: "Caio", author: "Marques"))
    }
}
