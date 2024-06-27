//
//  HomeViewModel.swift
//  MonkyBook
//
//  Created by Caio Marques on 24/06/24.
//

import Foundation

extension HomeView {
    class HomeViewModel : ObservableObject{
        let controller = ServerController()
        @Published var books : [Book] = []
        
        func removeBook (_ index : IndexSet) {
            books.remove(atOffsets: index)

            if let index = index.first {
                if books.count > index {
                    let removedBook = books[index]
                    let idString = removedBook.id
                    
                    guard let id = UUID(uuidString: idString) else {
                        print("Erro ao transformar idString em UUID")
                        return
                    }
                    
                    Task {
                        let _ = try await controller.removeBook(id)
                    }
                }
            }
        }
        
        func fetchBooks () {
            Task {
                if let booksFetched = try await controller.fetchBooks() {
                    self.books = booksFetched
                }
            }
        }
    }
}
