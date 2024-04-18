//
//  ViewModelProtocols.swift
//  RickYMorty
//
//  Created by Ruben Higuera on 17/04/24.
//

import Foundation


//MARK: - HomeProtocols

protocol HomeViewModelProtocol: ObservableObject, Identifiable {
    var characterList: CharacerListModel? {get}
    func getList(url: UrlType, search: String?, characterDetail: String?, page: String?)
    var success: Bool {get set}
}

//MARK: - DetailProtocols
protocol DetailViewModelProtocol: ObservableObject, Identifiable {
    func getCharacterData(url: UrlType, characterDetail: String?)
    var character: CharacterModel? {get}
    var success: Bool {get set}
}
