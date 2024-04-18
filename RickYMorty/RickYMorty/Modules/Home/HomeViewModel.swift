//
//  HomeViewModel.swift
//  RickYMorty
//
//  Created by Ruben Higuera on 16/04/24.
//

import Foundation
import Combine

class HomeViewModel: HomeViewModelProtocol {
    @Published var success: Bool = false
    @Published var characterList: CharacerListModel?
    private var subsriptions = Set<AnyCancellable>()
    let interactor = RickYMortyInteractor()
    let network = NetworkResourceManager()
    func getList(url: UrlType, search: String?, characterDetail: String?, page: String?) {
        interactor.currentDataPublisher(url: network.getUrl(url: url, search: search, characterDetail: characterDetail, page: page), model: CharacerListModel.self)
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
                self.characterList = value
            })
            .store(in: &subsriptions)
    }
}
