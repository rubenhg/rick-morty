//
//  DetailView.swift
//  RickYMorty
//
//  Created by Ruben Higuera on 16/04/24.
//

import SwiftUI

struct DetailView<Model>: View where Model : DetailViewModelProtocol {
    @ObservedObject var viewModel: Model
    @Binding var id: Int
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    var body: some View {
        VStack {
            if !viewModel.success {
                VStack {
                    Text("Error Getting Data")
                    Button("Retry") {
                        viewModel.getCharacterData(url: UrlType.characterDetail, characterDetail: String(id))
                    }
                }
            }else {
                VStack(spacing: 10) {
                    AsyncImage(url: URL(string: viewModel.character?.image ?? "")) { image in
                        image
                            .resizable()
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: idiom == .pad ? 400 : 300)
                    Text("Name: \(viewModel.character?.name ?? "")")
                        .font(.subheadline)
                    Text("Gender: \(viewModel.character?.gender ?? "")")
                        .font(.subheadline)
                    Text("Spicie: \(viewModel.character?.species ?? "")")
                        .font(.subheadline)
                    Text("Location: \(viewModel.character?.location?.name ?? "")")
                        .font(.subheadline)
                    Text("Episodes Count: \(String(viewModel.character?.episode?.count ?? 0))")
                        .font(.subheadline)
                    Spacer()
                }
                .padding(.all, 16)
            }
        }.onAppear {
            viewModel.getCharacterData(url: UrlType.characterDetail, characterDetail: String(id))
        }
    }
}

#Preview {
   
    DetailView(viewModel: DetailViewModel(), id: .constant(0))
}
