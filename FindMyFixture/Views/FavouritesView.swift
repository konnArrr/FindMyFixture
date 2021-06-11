//
//  FavouritesView.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import SwiftUI

struct FavouritesView: View {
    
    @StateObject var viewModel = FavouritesViewModel()
    
    
    var body: some View {
        NavigationView {

            List {
                ForEach(viewModel.favouriteFixturesVm, id: \.id) { fixture in
                    NavigationLink(destination: DetailView(fixture: fixture, showAddButton: false)) {
                        RowViewFavourites(fixture: fixture)
                    }
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
            }
            .navigationTitle("Favourites")
            .toolbar {
                EditButton()
            }
        }
    }
    private func delete(at offsets: IndexSet) {
        viewModel.deleteFromFavouriteList(at: offsets)
    }
    private func move(from source: IndexSet, to destination: Int) {
        viewModel.moveFavouriteList(from: source, to: destination)
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
