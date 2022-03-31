//
//  AddView.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import SwiftUI
import Combine

private let logger = Logger.getLogger(AddView.self, level: .verbose)


struct AddView: View {
    @StateObject var viewModel = AddViewModel()
    
    var body: some View {
        VStack{
            Form {
                ForEach(viewModel.sectionViewModel.indices){ index in
                    let section = viewModel.sectionViewModel[index]
                    SectionView(sectionViewModel: section)
                }
            }
            Text("\(viewModel.message)")
                .multilineTextAlignment(.center)
                .font(.title2)
            Button {
                viewModel.addFixture() {success in
                    if !success {
                        // show alert
                    }
                }
            } label: {
                Text("store")
                    .font(.title2)
            }
        }
        .padding()    
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}

