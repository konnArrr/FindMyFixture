//
//  ListSearchView.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import SwiftUI

struct ListSearchView: View {
    
    @StateObject var viewModel = ListSearchViewModel()
    @State private var searchString: String = ""
    @State private var showCancelButton: Bool = false
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                // search field
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("search", text: $searchString, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        })
                        .foregroundColor(.primary)
                        .disableAutocorrection(true)
                        Button(action: {
                            self.searchString = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchString == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                    
                    if showCancelButton  {
                        Button("Cancel") {
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.searchString = ""
                            self.showCancelButton = false
                        }
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                .padding(.horizontal)
                .navigationBarHidden(showCancelButton)
                .onChange(of: searchString) {newValue in
                    viewModel.searchFixturesByName(searchTerm: newValue)
                    
                }
                
                
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.fixturesToShow, id: \.id) {fixture in
                            NavigationLink(destination: DetailView(fixture: fixture, showAddButton: true)) {
                                RowView(fixture: fixture)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .onAppear {
                    viewModel.loadAllFixture(){success in
                        if !success {
                            // show alert
                        }
                    }
                }                
            }
            .navigationTitle("All Fixtures")
        }
    }
}





extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
