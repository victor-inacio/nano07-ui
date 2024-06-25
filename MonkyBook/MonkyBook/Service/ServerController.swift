//
//  ServerController.swift
//  MonkyBook
//
//  Created by Caio Marques on 25/06/24.
//

import Foundation

class ServerController {
    func fetchBooks () async throws -> [Book]? {
        return []
    }
    
    func getBook (_ id : UUID) async throws -> Book? {
        return Book(name: "", sinopse: "", author: "Giovanni")
    }
    
    func addBook (_ book : Book) async throws -> Int {
        return 200
    }
    
    func removeBook (_ id : UUID) async throws -> Int {
        return 200
    }
    
    func updateBook (_ id : UUID, book: Book) async throws -> Int {
        return 200
    }
}
