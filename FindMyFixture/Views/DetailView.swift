//
//  DetailView.swift
//  FindMyFixture
//
//  Created by Student on 11.06.21.
//

import SwiftUI

struct DetailView: View {
    
    let fixture: Fixture
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                Text("\(fixture.name)")
            }
            Section(header: Text("Producer")) {
                Text("\(fixture.producer)")
            }
            Section(header: Text("Power (total/light source")) {
                HStack {
                    Text("\(fixture.power)")
                    Text("\(fixture.powerLight)")
                }
            }
        }
        .toolbar {
            ToolbarItem {
                Button {
                    print("pressed")
                } label: {
                    Text("add to favourites")
                }

            }
        }
    }
}


