//
//  DetailViewModel.swift
//  RickYMorty
//
//  Created by Ruben Higuera on 16/04/24.
//

import Foundation
import Combine
import SwiftUI

class DetailViewModel: DetailViewModelProtocol {
    @Published var success: Bool = false
    @Published var character: CharacterModel?
    private var subsriptions = Set<AnyCancellable>()
    let interactor = RickYMortyInteractor()
    let network = NetworkResourceManager()
    func getCharacterData(url: UrlType, characterDetail: String?) {
        interactor.currentDataPublisher(url: network.getUrl(url: url, search: nil, characterDetail: characterDetail, page: nil), model: CharacterModel.self)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { response in
                switch response {
                case .failure(let error):
                    self.success = false
                    print("Failed with error: \(error)")
                    return
                case .finished:
                    self.success = true
                    print("Succeesfully finished!")
                }
            }, receiveValue: { value in
                self.character = value
            })
            .store(in: &subsriptions)
    }
}
