//
//  MonkyBookTests.swift
//  MonkyBookTests
//
//  Created by Caio Marques on 24/06/24.
//

import XCTest
@testable import MonkyBook

/// Classe de testes cujo objetivo é testar todas as funções do CRUD básico de livros dentro da API
final class CRUDLivroTests: XCTestCase {
    // dois objetos serão usados para construir os casos de testes, o controller, que contém as funções que vão executar as operações de acesso ao banco de dados e o Book
    var controller : ServerController!
    var book : Book!
    
    // inicializando ambos os objetos de teste, o book eu montei com nome e autor
    override func setUpWithError() throws {
        controller = ServerController()
        book = Book(name: "Test book", author: "Giovanni")
    }
    
    override func tearDownWithError() throws {
        controller = nil
    }
    
    /// Testa se ele adiciona um livro
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
    
    /// Teste que verifica se a funcionalidade de deleção de algum elemento realmente funciona
    func test_ServerController_isDeleting_shouldBeTrue () async throws {
        // when
        var idItemCreated : String = ""
        
        // adiciona o livro padrão no banco de dados, depois coloca o id gerado na variável idItemCreated
        let returnedData = try await controller.addBook(book)
        let returnedBook = returnedData.0
        if let idReturnedBook = returnedBook?.id {
            idItemCreated = idReturnedBook
        }
        
        // transforma esse id retornado em UUID para fins de remoção do elemento e procura dele na API, se não for possível transformar em UUID, o teste falha
        guard let id = UUID(uuidString: idItemCreated) else {
            XCTFail("Não conseguimos traduzir a string para id")
            return
        }
        
        // removendo o livro e procurando o livro removido dentro da API
        let statusCode = try await controller.removeBook(id)
        let deletedBook = try await controller.getBook(id)
        
        // assert
        
        // o objetivo é que o statusCode da remoção seja 200 (indicativo de que funcionou) e a função que busque o livro retorne nil, já que esse livro não está mais no banco de dados.
        XCTAssertEqual(statusCode, 200)
        XCTAssertNil(deletedBook)
    }
    
    /// Teste que verifica se está atualizando os valores de um book na API
    func test_ServerController_isUpdating_shouldUpdate () async throws {
        var idItemCreated : String = ""
        
        // primeiro passo é adicionar o book padrão na API
        let returnedData = try await controller.addBook(book)
        
        // aqui eu to pegando o id do book criado
        if let id = returnedData.0?.id {
            idItemCreated = id
        }
        
        // aqui o livro é atualizado com os dados setados na updatedBook e depois o statusCode da requisição é retornado e analisado se ele é 200 (o que significa que a atualização foi um sucesso.
        let updatedBook = Book(name: "Testbook 2", author: "Caio Oliveira")
        
        guard let id = UUID(uuidString: idItemCreated) else {
            XCTFail("Não conseguimos traduzir a string para UUID")
            return
        }
        
        let statusCode = try await controller.updateBook(id, book: updatedBook)
        
        XCTAssertEqual(statusCode, 200)
        
        // depois a gente pega o livro de dentro da api com o id conhecido e verifica se as informações condizem com o objeto updatedBook (o que a gente usou para atualizar os dados do book
        let returnedUpdatedBook = try await controller.getBook(id)
        
        XCTAssertNotNil(returnedUpdatedBook)
        XCTAssertEqual(updatedBook.name, returnedUpdatedBook?.name)
        XCTAssertEqual(updatedBook.author, returnedUpdatedBook?.author)
    }
    
    /// Teste que verifica se o controller está retornando uma lista de livros
    func test_ServerController_isFetching_shouldFetchData  () async throws {
        // chama a função fetchBooks e verifica se não retorna um valor nulo.
        let books = try await controller.fetchBooks()
        XCTAssertNotNil(books)
    }
}
