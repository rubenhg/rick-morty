//
//  CharacterModel.swift
//  RickYMorty
//
//  Created by Ruben Higuera on 16/04/24.
//

import Foundation

// MARK: - CharacerDetailModel
struct CharacterModel: Codable {
    let id: Int?
    let name, status, species, type: String?
    let gender: String?
    let origin, location: CharacterLocation?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

// MARK: - Location
struct CharacterLocation: Codable {
    let name: String?
    let url: String?
}
