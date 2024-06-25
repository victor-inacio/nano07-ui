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
        book = Book(name: "Test book", sinopse: "sim", author: "Giovanni")
    }
    
    override func tearDownWithError() throws {
        controller = nil
    }
    
    func test_ServerController_isAdding_shouldBeTrue () async {
        // given
        let status = try? await controller.addBook(book)
        let bookReturned = try? await controller.getBook(book.id)
        
        XCTAssertEqual(status, 200)
        XCTAssertEqual(book.name, bookReturned?.name)
        XCTAssertEqual(book.author, bookReturned?.author)
        XCTAssertEqual(book.sinopse, bookReturned?.sinopse)
        XCTAssertEqual(book.image, bookReturned?.image)
    }
    
    func test_ServerController_isDeleting_shouldBeTrue () async {
        // when
        let status = try? await controller.addBook(book)
        let statusDeletion = try? await controller.removeBook(book.id)
        let getDeletedBook = try? await controller.getBook(book.id)
        
        // then
        XCTAssertEqual(statusDeletion, 200)
        XCTAssertNil(getDeletedBook)
    }
    
    func test_ServerController_isUpdating_shouldUpdate () async {
        let status = try? await controller.addBook(book)
        
        let updatedBook = Book(name: "Cao", sinopse: "Lorem", author: "Ipsum")
        let statusUpdating = try? await controller.updateBook(book.id, book: updatedBook)
        
        XCTAssertEqual(statusUpdating, 200)
        
        let returnedBook = try? await controller.getBook(book.id)
        XCTAssertEqual(returnedBook?.name, updatedBook.name)
        XCTAssertEqual(returnedBook?.author, updatedBook.author)
        XCTAssertEqual(returnedBook?.sinopse, updatedBook.sinopse)
        XCTAssertEqual(returnedBook?.image, updatedBook.image)
    }
    
    func test_ServerController_isFetching_shouldFetchData () async {
        let bookList = try? await controller.fetchBooks()
        XCTAssertNotNil(bookList)
    }
    
    
}
