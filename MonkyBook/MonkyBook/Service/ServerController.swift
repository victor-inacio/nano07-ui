//
//  ServerController.swift
//  MonkyBook
//
//  Created by Caio Marques on 25/06/24.
//

import Foundation

class ServerController {
    let urlString = "http://localhost:8080/books"
    
    func fetchBooks ( completion: @escaping ((_ data : [Book]?, _ response : URLResponse?) -> Void)){
        guard let url = URL(string: urlString) else {return}
        let urlRequest = URLRequest(url: url)

        URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
            guard error == nil else { return }
            guard let data else { return }
            let json = try? JSONDecoder().decode([Book].self, from: data)
            completion(json, response)
        }.resume()
    }
    
    func getBook (_ id : UUID, completion : @escaping (_ data : Book?, _ response : URLResponse?) -> Void) {
        var urlString = self.urlString + "/\(id)"
        
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return }
            guard let data else { return }
            let json = try? JSONDecoder().decode(Book.self, from: data)
            completion(json, response)
        }.resume()
    }
    
    func addBook (_ book : Book, completion : @escaping (_ data : Book?, _ response : URLResponse?) -> Void) {
        guard let url = URL(string: urlString) else {  return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "name": book.name,
            "author": book.author
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])

        URLSession.shared.dataTask(with: request) { data, response, error in
            // Se tiver um erro, retorne
            print("o")
            guard error == nil else {return}
            guard let data else {return}
            
            
            let book = try? JSONDecoder().decode(Book.self, from: data)

            completion(book, response)
        }.resume()
        print("o")
    }
    
    func removeBook (_ id : UUID, completion : @escaping (_ statusCode : Int?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            
            if let response = response as? HTTPURLResponse {
                completion(response.statusCode)
            }
        }
    }
    
    func updateBook (_ id : UUID, book: Book, _ completion : @escaping (_ statusCode : Int?) -> Void) {
        var urlString = self.urlString + "/\(id)"
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "name": book.name,
            "author": book.author
        ]
        
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard error == nil else { fatalError("erro") }
            
            if let response = response as? HTTPURLResponse {
                completion(response.statusCode)
            }
        }
    }
}
