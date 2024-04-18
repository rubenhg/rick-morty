//
//  RickYMortyInteractor.swift
//  RickYMorty
//
//  Created by Ruben Higuera on 16/04/24.
//

import Foundation
import Combine

class RickYMortyInteractor: NetworkManagerProtocol {
    
    func currentDataPublisher<T: Decodable>(url: String, model: T.Type) -> AnyPublisher<T, Error> {
        let session = URLSession.shared
        let decoder = JSONDecoder()
        guard let url = URL(string: url) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
