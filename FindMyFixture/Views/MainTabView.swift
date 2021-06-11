//
//  TabView.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import SwiftUI

struct MainTabView: View {
    
    let userId: Int
    
    
    @StateObject var viewModel = TabViewModel()
    
    
    var body: some View {
        //        Text("test")
        TabView {
            ListSearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass.circle")
                    Text("Fixtures")
                }
            FavouritesView()
                .tabItem {
                    Image(systemName: "hand.thumbsup")
                    Text("Favourites")
                }
            if viewModel.user.adminRights > 0 {
                AddView()
                    .tabItem {
                        Image(systemName: "goforward.plus")
                        Text("add")
                    }
            }
        }
        
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                VStack {
                    Image(systemName: "person.circle")
                    Button {
                        print("user is pressed")
                    } label: {
                        Text(viewModel.user.username)
                    }
                }
            }
        }
        .onAppear {
            self.viewModel.getCurrentUser(id: userId)
        }
        .navigationBarBackButtonHidden(true)
        
    }
    
    
    
    
}
