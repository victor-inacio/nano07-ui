//
//  ServerController.swift
//  MonkyBook
//
//  Created by Caio Marques on 25/06/24.
//

import Foundation

class ServerController {
    let urlString = "http://localhost:8080/books"
    
    func fetchBooks () async throws -> [Book]?  {
        guard let url = URL(string: self.urlString) else {
            throw URLError(.badURL)
        }
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let books = try JSONDecoder().decode([Book].self, from: data)
            return books
        } catch {
            print("Não conseguimos recuperar os livros...")
            return nil
        }
    }
    
    func getBook (_ id : UUID) async throws -> Book? {
        let urlString = self.urlString + "/\(id)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let request = URLRequest(url: url)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let book = try JSONDecoder().decode(Book.self, from: data)
            return book
        } catch {
            print("Não encontramos nenhum livro com esse ID.")
            return nil
        }
    }
    
    /// Uma função que vai adicionar um book e vai retornar o book criado e uma resposta em inteiro se a transação funcionou ou não
    func addBook (_ book : Book) async throws -> (Book?, Int?) {
        // verificando se a url existe, se não jogando um erro de URL ruim
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        // configurando a requisição
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // setando os parâmetros da requisição
        let parameters: [String: Any] = [
            "name": book.name,
            "author": book.author
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        let urlResponse = response as? HTTPURLResponse
        let statusCode = urlResponse?.statusCode
        let bookDecoded = try JSONDecoder().decode(Book.self, from: data)
        
        return (bookDecoded, statusCode)
    }
    
    func removeBook (_ id : UUID) async throws -> Int? {
        let urlString = urlString + "/\(id)"
        
        // verificando se a url existe, se não jogando um erro de URL ruim
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        let responseHTTP = response as? HTTPURLResponse
        return responseHTTP?.statusCode
    }
    
    func updateBook (_ id : UUID, book: Book) async throws -> Int?  {
        let urlString = self.urlString + "/\(id)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "name": book.name,
            "author": book.author
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let (_, response) = try await URLSession.shared.data(for: request)
        let urlResponse = response as? HTTPURLResponse
        return urlResponse?.statusCode
    }
}
