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
    var author : String
    
    init(name: String, author : String) {
        self.name = name
        self.author = author
    }
}
