//
//  MonkyBookTests.swift
//  MonkyBookTests
//
//  Created by Caio Marques on 24/06/24.
//

import XCTest
@testable import MonkyBook

final class CRUDLivroTests: XCTestCase {
    var controller : ServerController!
    var book : Book!
    
    override func setUpWithError() throws {
        controller = ServerController()
        book = Book(name: "Test book", author: "Giovanni")
    }
    
    override func tearDownWithError() throws {
        controller = nil
    }
    
    func test_ServerController_isAdding_shouldBeTrue () {
        controller.addBook(book) { [weak self] data, response in
            guard let data = data else {
                XCTFail("Dados não retornados")
                return
            }
            
            XCTAssertEqual(data.name, self?.book.name)
            XCTAssertEqual(data.author, self?.book.author)
            XCTAssertNil(data)
        }
    }
    
    func test_ServerController_isDeleting_shouldBeTrue () {
        // when
        var idItemCreated : UUID = UUID()
        
        controller.addBook(book) { data, response in
            if let data {
                idItemCreated = data.id
            }
        }
        controller.removeBook(idItemCreated) { statusCode in
            XCTAssertEqual(statusCode, 200)
        }
        
        controller.getBook(book.id) {deletedBook, response in
            XCTAssertNil(deletedBook)
        }
    }
    
    func test_ServerController_isUpdating_shouldUpdate () {
        var id : UUID = UUID()
        
        controller.addBook(book) {data, response in
            //if let dataId = data?.id {id = dataId}
        }
        
        let updatedBook = Book(name: "Lorem", author: "Ipsum")
        controller.updateBook(id, book: updatedBook) {statusCode in
            XCTAssertEqual(statusCode, 200)
        }
        
        controller.getBook(id) {book, response in
            XCTAssertNotNil(book)
            XCTAssertEqual(book?.name, updatedBook.name)
            XCTAssertEqual(book?.author, updatedBook.author)
        }
    }
    
    func test_ServerController_isFetching_shouldFetchData () {
        controller.fetchBooks { (books, error) in
            XCTAssertNotNil(books)
        }
    }
    
    
}
