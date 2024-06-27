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
    
    func test_ServerController_isAdding_shouldBeTrue () async throws {
        // WHEN
        let returnedData = try await controller.addBook(book)
        let returnedBook = returnedData.0
        let returnedStatusCode = returnedData.1
        
        // ASSERT
        
        // verificando se o status code retornado é 200
        XCTAssertEqual(returnedStatusCode, 200)

        // verificando se os dados recebidos estão de acordo com o que se esperava
        XCTAssertEqual(returnedBook?.name, book.name)
        XCTAssertEqual(returnedBook?.author, book.author)
    }
    
    func test_ServerController_isDeleting_shouldBeTrue () async throws {
        // when
        var idItemCreated : String = ""
        
        let returnedData = try await controller.addBook(book)
        let returnedBook = returnedData.0
        if let idReturnedBook = returnedBook?.id {
            idItemCreated = idReturnedBook
        }
        
        guard let id = UUID(uuidString: idItemCreated) else {
            XCTFail("Não conseguimos traduzir a string para id")
            return
        }
        
        let statusCode = try await controller.removeBook(id)
        let deletedBook = try await controller.getBook(id)
        
        // assert
        XCTAssertEqual(statusCode, 200)
        XCTAssertNil(deletedBook)
    }
    
    func test_ServerController_isUpdating_shouldUpdate () async throws {
        var idItemCreated : String = ""
        
        let returnedData = try await controller.addBook(book)
        if let id = returnedData.0?.id {
            idItemCreated = id
        }
        
        let updatedBook = Book(name: "Testbook 2", author: "Caio Oliveira")
        
        guard let id = UUID(uuidString: idItemCreated) else {
            XCTFail("Não conseguimos traduzir a string para UUID")
            return
        }
        
        let statusCode = try await controller.updateBook(id, book: updatedBook)
        
        XCTAssertEqual(statusCode, 200)
        
        let returnedUpdatedBook = try await controller.getBook(id)
        
        XCTAssertNotNil(returnedUpdatedBook)
        XCTAssertEqual(updatedBook.name, returnedUpdatedBook?.name)
        XCTAssertEqual(updatedBook.author, returnedUpdatedBook?.author)
        
        /*
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
            X
        }
         */
    }
    
    
    func test_ServerController_isFetching_shouldFetchData  () async throws {
        let books = try await controller.fetchBooks()
        XCTAssertNotNil(books)
    }
}
