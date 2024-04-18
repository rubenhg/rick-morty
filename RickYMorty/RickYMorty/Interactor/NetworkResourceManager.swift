//
//  NetworkResourceManager.swift
//  RickYMorty
//
//  Created by Ruben Higuera on 16/04/24.
//

import Foundation

enum UrlType: String {
    case character
    case search
    case characterDetail
    case pagination
    
    var description: String {
        switch self {
        case .character:
            return "https://rickandmortyapi.com/api/character"
        case .search:
            return "https://rickandmortyapi.com/api/character/?page=¿&name=@"
        case .characterDetail:
            return "https://rickandmortyapi.com/api/character/@"
        case .pagination:
            return "https://rickandmortyapi.com/api/character/?page=@"
        }
    }
}

class NetworkResourceManager {
    func getUrl(url: UrlType, search: String?, characterDetail: String?, page: String?) -> String {
        switch url {
        case .character:
            return UrlType.character.description
        case .search:
            let replaceOne = UrlType.search.description.replacingOccurrences(of: "@", with: search ?? "")
            let replaceTwo = replaceOne.replacingOccurrences(of: "¿", with: page ?? "")
            return replaceTwo
        case .characterDetail:
            return UrlType.characterDetail.description.replacingOccurrences(of: "@", with: characterDetail ?? "")
        case .pagination:
            return UrlType.pagination.description.replacingOccurrences(of: "@", with: page ?? "")
        }
    }
}
