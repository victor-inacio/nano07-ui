//
//  AddViewModel.swift
//  MonkyBook
//
//  Created by Caio Marques on 27/06/24.
//

import Foundation

extension AddView {
    class AddViewModel : ObservableObject {
        @Published var bookName: String = ""
        @Published var authorName: String = ""
        let controller = ServerController()
        
        func saveBook () {
            let book = Book(name: bookName, author: authorName)
            
            Task {
                try await controller.addBook(book)
            }
        }
    }
}
