//
//  InteractorProtocol.swift
//  RickYMorty
//
//  Created by Ruben Higuera on 17/04/24.
//

import Foundation
import Combine

protocol NetworkManagerProtocol {
    func currentDataPublisher<T: Decodable>(url: String, model: T.Type) -> AnyPublisher<T, Error>
}
