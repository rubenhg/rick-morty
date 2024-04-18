//
//  RickYMortyTests.swift
//  RickYMortyTests
//
//  Created by Ruben Higuera on 16/04/24.
//

import XCTest
@testable import RickYMorty
import Combine

final class RickYMortyTests: XCTestCase {
    
    var mockNetworkManager: MockNetworkManager!
    var interactor: RickYMortyInteractor!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        mockNetworkManager = MockNetworkManager()
        interactor = RickYMortyInteractor()
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDownWithError() throws {
        cancellables = nil
        interactor = nil
        mockNetworkManager = nil
    }
    
    func testCurrentDataPublisher_Success() {
        let publisher = interactor.currentDataPublisher(url: "https://rickandmortyapi.com/api/character/1", model: CharacterModel.self)
        
        // Then
        let expectation = XCTestExpectation(description: "Receive character data")
        var receivedCharacter: CharacterModel?
        var receivedError: Error?
        
        let cancellable = publisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    receivedError = error
                case .finished:
                    break
                }
            }, receiveValue: { character in
                receivedCharacter = character
                expectation.fulfill() // Fulfill the expectation when receiving the value
            })
        
        wait(for: [expectation], timeout: 5.0) // Increase timeout to 5 seconds
        
        XCTAssertNotNil(receivedCharacter)
        XCTAssertNil(receivedError)
        XCTAssertEqual(receivedCharacter?.name, "Rick Sanchez")
    }
    
    func testCurrentDataPublisher_Failure() {
        // Given
        let expectedErrorCode = URLError.Code.unsupportedURL.rawValue
        let expectedErrorDomain = URLError.errorDomain
        
        let expectedError = URLError(URLError.Code(rawValue: expectedErrorCode), userInfo: [:])
        mockNetworkManager.error = expectedError
        
        // When
        let publisher = interactor.currentDataPublisher(url: "invalidURL", model: CharacterModel.self)
        
        // Then
        let expectation = XCTestExpectation(description: "Receive error")
        var receivedError: Error?
        
        let cancellable = publisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    receivedError = error
                    expectation.fulfill() // Fulfill the expectation when receiving the error
                case .finished:
                    break
                }
            }, receiveValue: { _ in })
        
        wait(for: [expectation], timeout: 5.0) // Increase timeout to 5 seconds
        
        XCTAssertNotNil(receivedError)
        XCTAssertEqual((receivedError as NSError?)?.code, expectedErrorCode)
        XCTAssertEqual((receivedError as NSError?)?.domain, expectedErrorDomain)
    }
    
}
