//
//  CharacterListModel.swift
//  RickYMorty
//
//  Created by Ruben Higuera on 16/04/24.
//

import Foundation

// MARK: - CharacerListModel
struct CharacerListModel: Codable {
    let info: CharacerListInfo?
    let results: [CharacerListResult]?
}

// MARK: - Info
struct CharacerListInfo: Codable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

// MARK: - Result
struct CharacerListResult: Codable {
    let id: Int?
    let name, status, species, type: String?
    let gender: String?
    let origin, location: CharacerListLocation?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

// MARK: - Location
struct CharacerListLocation: Codable {
    let name: String?
    let url: String?
}
