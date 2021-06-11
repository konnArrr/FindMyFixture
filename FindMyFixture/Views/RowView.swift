//
//  ListRowView.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import SwiftUI

struct RowView: View {
    
    let fixture: Fixture
    @State var fixtureImage: Image?
    
    @StateObject var viewModel = RowViewModel()
    
    var body: some View {
        
        VStack {
            Divider()
            HStack {
                
                Spacer()
                    .frame(width: 10)
                if let fixtureImage = fixtureImage {
                    fixtureImage
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .overlay(Circle().stroke(Color.red, lineWidth: 2))
                }
                Spacer()
                VStack {
                    Text(fixture.name)
                    Text(fixture.producer)
                }
                Spacer()
                Image(systemName: "chevron.right")
                Spacer()
                    .frame(width: 10)
            }
            .padding(.all, 5)
            .shadow(radius: 10)
        }
        
        
        .onAppear {
            viewModel.getFixtureImage(imageURLString: fixture.imageURL)
        }
        .onReceive(viewModel.$fixtureImage) { (newImage) in
            guard let newImage = newImage else { return }
            fixtureImage = Image(uiImage: newImage)
        }
        
        
    }
}

