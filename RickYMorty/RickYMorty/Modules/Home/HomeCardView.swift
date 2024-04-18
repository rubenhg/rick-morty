//
//  HomeCardView.swift
//  RickYMorty
//
//  Created by Ruben Higuera on 16/04/24.
//

import SwiftUI

struct HomeCardViewModel {
    let image: String?
    let name: String?
    let id: Int?
}

struct HomeCardView: View {
    let cardAndImageWidth: CGFloat = 150
    let cardHeight: CGFloat = 150
    let cornerRadius: CGFloat = 5
    let lineWith = 2
    var viewModel: HomeCardViewModel?
    @Binding var id: Int
    @Binding var showDetails: Bool
    var body: some View {
        VStack {
            // async image loading
            AsyncImage(url: URL(string: viewModel?.image ?? "")) { image in
                image
                    .resizable()
                    .clipped()
            } placeholder: {
                //Spinner
                ProgressView()
            }
            .frame(width: 120, height: 120)
            Text(viewModel?.name ?? "")
                .font(.caption)
                .font(.caption.bold())
        }
        .padding()
        .onTapGesture {
            id = viewModel?.id ?? 0
            showDetails = true
        }
        .frame(width: cardAndImageWidth, height: cardHeight)
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.teal, lineWidth: CGFloat(lineWith))
        }
    }
}

#Preview {
    HomeCardView(id: .constant(0), showDetails: .constant(false))
}
