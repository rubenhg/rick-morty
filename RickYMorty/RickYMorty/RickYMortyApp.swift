//
//  RickYMortyApp.swift
//  RickYMorty
//
//  Created by Ruben Higuera on 16/04/24.
//

import SwiftUI

@main
struct RickYMortyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: HomeViewModel())
        }
    }
}
