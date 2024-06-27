//
//  EditViewModel.swift
//  MonkyBook
//
//  Created by Caio Marques on 27/06/24.
//

import Foundation

extension EditView {
    class EditViewModel : ObservableObject {
        var book : Book?
        @Published var bookName = ""
        @Published var bookAuthor = ""
        let controller = ServerController()
        
        func setup (_ book : Book) {
            self.book = book
            self.bookName = self.book?.name ?? ""
            self.bookAuthor = self.book?.author ?? ""
        }
        
        func editBook () {
            guard let book else {
                print("Não deu para editar porque não tem book")
                return
            }
            
            guard let id = UUID(uuidString: book.id) else {
                print("Não foi possível converter o id")
                return
            }
            
            let updatedBook = Book(name: bookName, author: bookAuthor)
            Task {
                try await controller.updateBook(id, book: updatedBook)
            }
        }
    }
}
