//
//  MockNetworkManager.swift
//  RickYMortyTests
//
//  Created by Ruben Higuera on 17/04/24.
//

import Foundation
import Combine

class MockNetworkManager: NetworkManagerProtocol {
    var data: Data?
    var error: Error?

    func currentDataPublisher<T: Decodable>(url: String, model: T.Type) -> AnyPublisher<T, Error> {
        if let error = error {
            return Fail(error: error).eraseToAnyPublisher()
        } else if let data = data {
            return Just(data)
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { error -> Error in
                    error as Error
                }
                .eraseToAnyPublisher()
        } else {
            fatalError("Provide either data or error for testing")
        }
    }
}
