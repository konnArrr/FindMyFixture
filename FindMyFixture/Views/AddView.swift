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


//struct AddView: View {
//
//    @StateObject var viewModel = AddViewModel()
//
//
//
//    let intFomatter = NumberFormatter()
//
//    var decimalFormatter : NumberFormatter {
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .decimal
//        formatter.maximumFractionDigits = 2
//        return formatter
//    }
//
//    var sectionName: some View {
//        Section(header: Text("Name")) {
//            TextField("enter name", text: $fixture.name)
//        }
//        .onChange(of: fixture.name) { input in
//            logger.verbose(fixture.name)
//        }
//    }
//
//    var sectionProducer: some View {
//        Section(header: Text("Producer")) {
//            TextField("enter producer", text: $fixture.producer)
//        }
//    }
//
//    var sectionPower: some View {
//        Section(header: Text("Total Power || Light Source Power)")) {
//            HStack {
//                TextField("enter power", value: $fixture.power, formatter: intFomatter)
//                    .keyboardType(.numberPad)
//                Divider()
//                TextField("enter light power", value: $fixture.powerLight, formatter: intFomatter)
//                    .keyboardType(.numberPad)
//            }
//        }
//    }
//
//    var sectionLampType: some View {
//        Section(header: Text("Lamp Type")) {
//            Picker(selection: $fixture.headMover, label: Text("")) {
//                ForEach(LampType.allCases, id: \.self) {
//                    Text($0.getName()).tag($0.rawValue)
//                }
//            }
//            .pickerStyle(SegmentedPickerStyle())
//            .onChange(of: fixture.headMover) { (lamptype) in
//                logger.verbose("headmover \(fixture.headMover)")
//            }
//        }
//    }
//
//    var sectionGoPri: some View {
//        Section(header: Text("Number Gobo Wheels || Number Prism Wheels")) {
//            HStack {
//                TextField("enter gobo wheels", value: $fixture.goboWheels, formatter: intFomatter)
//                    .keyboardType(.numberPad)
//                Divider()
//                TextField("enter prisms", value: $fixture.prisms, formatter: intFomatter)
//                    .keyboardType(.numberPad)
//            }
//        }
//    }
//
//    var sectionZoom: some View {
//        Section(header: Text("Zoom Min || Max")) {
//            HStack {
//                TextField("enter min zoom", value: $fixture.minZoom, formatter: decimalFormatter)
//                    .keyboardType(.decimalPad)
//                Divider()
//                TextField("enter max zoom", value: $fixture.maxZoom, formatter: decimalFormatter)
//                    .keyboardType(.decimalPad)
//            }
//        }
//    }
//
//    var sectionColorMix: some View {
//        Section(header: Text("Color Mix System")) {
//            Picker(selection: $fixture.colorSystem, label: Text("")) {
//                ForEach(ColorSystem.allCases, id: \.self) {
//                    Text($0.getName()).tag($0.rawValue)
//                }
//            }
//            .pickerStyle(SegmentedPickerStyle())
//        }
//    }
//
//    var sectionDmx: some View {
//        Section(header: Text("DMX Number Modes || Min Channel || Max Channel")) {
//            HStack {
//                TextField("enter dmx modes", value: $fixture.dmxModes, formatter: intFomatter)
//                    .keyboardType(.numberPad)
//                Divider()
//                TextField("enter min dmx", value: $fixture.minDmx, formatter: intFomatter)
//                    .keyboardType(.numberPad)
//                Divider()
//                TextField("enter max dmx", value: $fixture.maxDmx, formatter: intFomatter)
//                    .keyboardType(.numberPad)
//            }
//        }
//    }
//
//    var sectionWeight: some View {
//        Section(header: Text("Weight")) {
//            TextField("enter weight", value: $fixture.weight, formatter: intFomatter)
//                .keyboardType(.numberPad)
//        }
//    }
//
//    var sectionComment: some View {
//        Section(header: Text("Comment")) {
//            TextField("enter comment", text: $fixture.comment)
//        }
//    }
//
//
//
//
//
//
//    var body: some View {
//        VStack {
//            Form {
//                sectionName
//                sectionProducer
//                sectionPower
//                sectionLampType
//                sectionGoPri
//                sectionZoom
//                sectionColorMix
//                sectionDmx
//                sectionWeight
//                sectionComment
//            }
//            VStack {
//                Text("\(viewModel.message)")
//                    .multilineTextAlignment(.center)
//                    .font(.title2)
//                Button {
//                    viewModel.addFixture() {success in
//                        if !success {
//                            // show alert
//                        }
//                    }
//                } label: {
//                    Text("store")
//                        .font(.title2)
//                }
//
//            }
//            .padding()
//        }
//    }
//}
//
//
//
//struct AddView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddView()
//    }
//}
