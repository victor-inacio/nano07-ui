//
//  Book.swift
//  MonkyBook
//
//  Created by Caio Marques on 24/06/24.
//

import Foundation

class Book : Encodable, Decodable{
    var id : UUID = UUID()
    var name : String
    var sinopse : String
    var author : String
    var image : Data?
    
    init(name: String, sinopse: String, image: Data? = nil, author : String) {
        self.name = name
        self.sinopse = sinopse
        self.image = image
        self.author = author
    }
}
