//
//  DetailView.swift
//  FindMyFixture
//
//  Created by Student on 11.06.21.
//

import SwiftUI

struct DetailView: View {
    
    let fixture: Fixture
    
    let showAddButton: Bool
    
    @State var fixtureImage: Image?
    
    @StateObject var viewModel = DetailViewModel()
    
    
    var body: some View {
        VStack {
            if let image = fixtureImage {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                    .overlay(Circle().stroke(Color.red, lineWidth: 2))
            }
        }
        .onAppear {
            viewModel.getFixtureImage(imageURLString: fixture.imageURL)
        }
        .onReceive(viewModel.$fixtureImage) { (newImage) in
            guard let newImage = newImage else { return }
            fixtureImage = Image(uiImage: newImage)
        }
        
        Form {
            Section(header: Text("Name")) {
                Text("\(fixture.name)")
            }
            Section(header: Text("Producer")) {
                Text("\(fixture.producer)")
            }
            Section(header: Text("Power Total || Light Source)")) {
                HStack {
                    Spacer()
                    Text("\(fixture.power)")
                    Spacer()
                    Divider()
                    Spacer()
                    Text("\(fixture.powerLight)")
                    Spacer()
                }
            }
            Section(header: Text("Lamp Type")) {
                Text("\(fixture.lampType.getName())")
            }
            Section(header: Text("Gobo Wheels || Prism Wheels")) {
                HStack {
                    Spacer()
                    Text("\(fixture.goboWheels)")
                    Spacer()
                    Divider()
                    Spacer()
                    Text("\(fixture.prisms)")
                    Spacer()
                }
            }
            Section(header: Text("Zoom Min || Max")) {
                HStack {
                    Spacer()
                    Text("\(fixture.minZoom)")
                    Spacer()
                    Divider()
                    Spacer()
                    Text("\(fixture.maxZoom)")
                    Spacer()
                }
            }
            Section(header: Text("Color Mix System")) {
                Text("\(fixture.colorSysEnum.getName())")
            }
            Section(header: Text("DMX Number Modes || Min || Max")) {
                HStack {
                    Text("\(fixture.dmxModes)")
                    Spacer()
                    Divider()
                    Spacer()
                    Text("\(fixture.minDmx)")
                    Spacer()
                    Divider()
                    Spacer()
                    Text("\(fixture.maxDmx)")
                }
            }
            Section(header: Text("Weight")) {
                Text("\(fixture.weight)")
            }
            Section(header: Text("Comment")) {
                Text("\(fixture.comment)")
            }
        }
        .onAppear {
            StorageLoader.shared.loadFavouriteFixturesList()
        }
        //        .navigationTitle("Detail View")
        .toolbar {
            
            ToolbarItem {
                if showAddButton {
                    Button {
                        sendAddMsgToStorageLoader()
                    } label: {
                        Text("add to favourites")
                    }                    
                } else {
                    EmptyView()
                }
                
            }
            
            
        }
        
        
    }
    
    private func sendAddMsgToStorageLoader() {
        NotificationCenter.default.post(name: .addFavouriteFixtureMessage, object: fixture)
        print("add pressed")
    }
    
    
}


