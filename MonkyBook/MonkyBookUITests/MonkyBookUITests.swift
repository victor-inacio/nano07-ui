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
        let app = XCUIApplication()
        app.launch()
        
        let collectionViewsQuery = XCUIApplication().collectionViews

        
        let itemList = collectionViewsQuery.children(matching: .cell).element(boundBy: 1).buttons["Houseki No Kuni, Houseki No Kuni"]
        XCTAssert(itemList.exists)
        itemList.swipeLeft()
        
        
        let deleteButton = collectionViewsQuery.buttons["Delete"]
        XCTAssert(deleteButton.exists)
        deleteButton.swipeLeft()
    }
    
    func testEditBook () throws {
        let app = XCUIApplication()
        app.launch()
        
        
        let listItem = app.collectionViews.children(matching: .cell).element(boundBy: 1).buttons["Houseki No Kuni, Houseki No Kuni"].children(matching: .staticText).matching(identifier: "Houseki No Kuni").element(boundBy: 1)
        //XCTAssert(listItem.exists)
        listItem.tap()
        
        let window = app.children(matching: .window).element(boundBy: 0)
        let element = window.children(matching: .other).element.children(matching: .other).element
        XCTAssert(element.exists)
        element.tap()
        
        let textField = element.children(matching: .textField).matching(identifier: "Insert book name here").element(boundBy: 0)
        XCTAssert(textField.exists)
        textField.tap()
        textField.typeText("Nightmare")
        
        let insertBookNameHereTextField = element.children(matching: .textField).matching(identifier: "Insert book author here").element(boundBy: 0)
        XCTAssert(insertBookNameHereTextField.exists)
        insertBookNameHereTextField.tap()
        insertBookNameHereTextField.typeText("Vanessa")
        
        let sendButton = app.buttons["Enviar"]
        XCTAssert(sendButton.exists)
        sendButton.tap()
        
    }
}
