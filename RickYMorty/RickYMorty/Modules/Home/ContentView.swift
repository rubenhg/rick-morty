//
//  ContentView.swift
//  RickYMorty
//
//  Created by Ruben Higuera on 16/04/24.
//

import SwiftUI


struct ContentView<Model>: View where Model: HomeViewModelProtocol {
    @ObservedObject private var viewModel: Model
    @State var presentDetail = false
    @State var id = 0
    @State var searchText = ""
    @State var page = 1
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    init(viewModel: Model) {
        self.viewModel = viewModel
        viewModel.getList(url: UrlType.character, search: nil, characterDetail: nil, page: nil)
    }
    var body: some View {
        if !viewModel.success {
            VStack {
                Text("Error Getting Data")
                Button("Retry") {
                    viewModel.getList(url: UrlType.character, search: nil, characterDetail: nil, page: nil)
                }
            }
        }else {
            NavigationStack{
                VStack {
                    SearchBar(text: $searchText, searchTapped: {
                        viewModel.getList(url: UrlType.search, search: searchText, characterDetail: nil, page: String(page))
                    }, cancelTapped: {
                        viewModel.getList(url: UrlType.character, search: nil, characterDetail: nil, page: nil)
                    })
                    ScrollView {
                        // Lazy will render when required to avoid memory lick
                        LazyVGrid(columns: idiom == .pad ? [
                            // fixed satatic value or felixible non static value
                            GridItem(.fixed(150)),
                            GridItem(.fixed(150)),
                            GridItem(.fixed(150))
                        ] : [
                            GridItem(.fixed(150)),
                            GridItem(.fixed(150))
                        ], spacing: 10) {
                            let data = viewModel.characterList?.results ?? []
                            ForEach(data, id: \.id) { i in
                                HomeCardView(viewModel: HomeCardViewModel(image: i.image, name: i.name, id: i.id), id: $id, showDetails: $presentDetail)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }.padding(.top, 16)
                    HStack {
                        if let str2 = viewModel.characterList?.info?.prev {
                            let lastChar = str2[str2.index(before: str2.endIndex)]
                            Button {
                                if searchText == "" {
                                    viewModel.getList(url: UrlType.pagination, search: nil, characterDetail: nil, page: String(lastChar))
                                }else {
                                    page -= 1
                                    viewModel.getList(url: UrlType.search, search: searchText, characterDetail: nil, page: String(page))
                                }
                                
                            } label: {
                                Text("Prev Page").foregroundStyle(.white).bold()
                            }
                            .padding()
                            .background(Color.teal)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.trailing, 16)
                        }
                        Spacer()
                        if let str = viewModel.characterList?.info?.next {
                            let lastChar = str[str.index(before: str.endIndex)]
                            Button{
                                if searchText == "" {
                                    viewModel.getList(url: UrlType.pagination, search: nil, characterDetail: nil, page: String(lastChar))
                                }else {
                                    page += 1
                                    viewModel.getList(url: UrlType.search, search: searchText, characterDetail: nil, page: String(page))
                                }
                            } label: {
                                Text("Next Page").foregroundStyle(.white).bold()
                            }
                            .padding()
                            .background(Color.teal)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.leading, 16)
                        }
                    }
                    .frame(maxWidth: .none, maxHeight: idiom == .pad ? 90 : 20)
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Rick & Morty").font(.system(size: 14))
                .navigationDestination(isPresented: $presentDetail) {
                    DetailView(viewModel: DetailViewModel(), id: $id)
                }
                .padding(.horizontal, 16)
            }
        }
    }
}

#Preview {
    ContentView(viewModel: HomeViewModel())
}
