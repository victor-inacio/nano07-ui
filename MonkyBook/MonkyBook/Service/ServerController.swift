//
//  ServerController.swift
//  MonkyBook
//
//  Created by Caio Marques on 25/06/24.
//

import Foundation

/// Uma classe que basicamente faz todas as requisições necessárias ao banco de dados
class ServerController {
    let urlString = "http://localhost:8080/books"
    
    private func request (_ link : String) throws -> URLRequest {
        // verificando se a url existe, se não jogando um erro de URL ruim
        guard let url = URL(string: self.urlString) else {
            throw URLError(.badURL)
        }
        return URLRequest(url: url)
    }
    
    /// Função que recupera todos os livros dentro da API.
    /// - returns: lista de todos os books dentro da API.
    func fetchBooks () async throws -> [Book]?  {
        let request = try request(urlString)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let books = try JSONDecoder().decode([Book].self, from: data)
            return books
        } catch {
            print("Não conseguimos recuperar os livros...")
            return nil
        }
    }
    
    /// Função que recupera um dos livros dentro da API a partir de um id
    /// - Parameters:
    ///     - id: id do livro que se deseja recuperar.
    /// - returns: o book buscado.
    func getBook (_ id : UUID) async throws -> Book? {
        let request = try request(urlString)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let book = try JSONDecoder().decode(Book.self, from: data)
            return book
        } catch {
            print("Não encontramos nenhum livro com esse ID.")
            return nil
        }
    }
    
    /// Uma função que vai adicionar um book no banco de dados da API
    /// - Parameters:
    ///     - book: objeto do tipo Book que se deseja adicionar
    /// - returns: o book gerado e um inteiro que representa o status code da requisição. Ambos opcionais caso a inserção não aconteça
    func addBook (_ book : Book) async throws -> (Book?, Int?) {
        // configurando a requisição
        var request = try request(urlString)
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
    
    /// Uma função que remove um book no banco de dados da API
    /// - Parameters:
    ///     - id: id do livro que se deseja remover
    /// - returns: Um inteiro que representa o status code da requisição.
    func removeBook (_ id : UUID) async throws -> Int? {
        var request = try request(urlString + "/\(id)")
        request.httpMethod = "DELETE"
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        let responseHTTP = response as? HTTPURLResponse
        return responseHTTP?.statusCode
    }
    
    /// Uma função que atualiza um book
    /// - Parameters:
    ///     - id: id do livro que se deseja atualizar
    ///     - book: um objeto do tipo Book que vai conter as informações que vão ser alteradas, como nome e autor
    /// - returns: Um inteiro que representa o status code da requisição.
    func updateBook (_ id : UUID, book: Book) async throws -> Int?  {
        var request = try request(self.urlString + "/\(id)")
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
