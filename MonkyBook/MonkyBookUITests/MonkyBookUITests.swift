//
//  MonkyBookUITests.swift
//  MonkyBookUITests
//
//  Created by Caio Marques on 24/06/24.
//

import XCTest

final class MonkyBookUITests: XCTestCase {
    func testAddBook() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        let addButton = app.navigationBars["Library App"].buttons["Add"]
        XCTAssert(addButton.exists)
        addButton.tap()
        
        let bookNameTextField = app.textFields["Add book name here..."]
        XCTAssert(bookNameTextField.exists)
        bookNameTextField.tap()
        bookNameTextField.typeText("Houseki No Kuni")
        
        
        let addAuthorSNameHereTextField = app.textFields["Add author's name here..."]
        XCTAssert(addAuthorSNameHereTextField.exists)
        addAuthorSNameHereTextField.tap()
        addAuthorSNameHereTextField.typeText("Houseki No Kuni")
        
        
        let saveButton = app.buttons["Salvar"]
        XCTAssert(saveButton.exists)
        saveButton.tap()
        
        let housekiNoKuniStaticText = app.collectionViews.staticTexts["Houseki No Kuni"]
        XCTAssert(housekiNoKuniStaticText.exists)
    }
    
    func testRemoveBook () throws {
        
        let collectionViewsQuery = XCUIApplication().collectionViews
        let element = collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element
        let element2 = element.children(matching: .other).element
        let housekiNoKuniStaticText = element2.children(matching: .staticText).matching(identifier: "Houseki No Kuni").element(boundBy: 1)
        
        XCTAssert(housekiNoKuniStaticText.exists)
        housekiNoKuniStaticText.swipeLeft()
        
        let deleteButton = collectionViewsQuery.buttons["Delete"]
        XCTAssert(deleteButton.exists)
        deleteButton.tap()
    }
}
