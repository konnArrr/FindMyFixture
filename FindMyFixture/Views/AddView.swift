//
//  AddView.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import SwiftUI
import Combine

struct AddView: View {
    
    @StateObject var viewModel = AddViewModel()
    
    @State var colorSys: ColorSystem = .cmy
    @State var lamptype: LampType = .nonHeadMover
    
    @State var power: String = ""
    @State var powerLight: String = ""
    @State var headMover: String = ""
    @State var goboWheels: String = ""
    @State var prisms: String = ""
    @State var minZoom: String = ""
    @State var maxZoom: String = ""
    @State var dmxModes: String = ""
    @State var minDmx: String = ""
    @State var maxDmx: String = ""
    @State var weight: String = ""
    
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Name")) {
                    TextField("enter name", text: $viewModel.fixtureToAdd.name)
                }
                Section(header: Text("Producer")) {
                    TextField("enter producer", text: $viewModel.fixtureToAdd.producer)
                }
                Section(header: Text("Total Power || Light Source Power)")) {
                    HStack {
                        TextField("enter power", text: $power)
//                            .keyboardType(.numberPad)
                            .onReceive(Just(power)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.power = filtered
                                            }
                            }
                            .onChange(of: power) { (power) in
                                viewModel.fixtureToAdd.power = Int(power) ?? 0
                            }
                        
//                        Spacer()
//                        Text("\(viewModel.fixtureToAdd.power)")
//                        Spacer()
//                        Divider()
//                        Spacer()
//                        Text("\(viewModel.fixtureToAdd.powerLight)")
//                        Spacer()
                    }
                }
                Section(header: Text("Lamp Type")) {
                    Text("\(viewModel.fixtureToAdd.lampType.getLampTypeName())")
                }
                Section(header: Text("Gobo Wheels || Prism Wheels")) {
                    HStack {
                        Spacer()
                        Text("\(viewModel.fixtureToAdd.goboWheels)")
                        Spacer()
                        Divider()
                        Spacer()
                        Text("\(viewModel.fixtureToAdd.prisms)")
                        Spacer()
                    }
                }
                Section(header: Text("Zoom Min || Max")) {
                    HStack {
                        Spacer()
                        Text("\(viewModel.fixtureToAdd.minZoom)")
                        Spacer()
                        Divider()
                        Spacer()
                        Text("\(viewModel.fixtureToAdd.maxZoom)")
                        Spacer()
                    }
                }
                Section(header: Text("Color Mix System")) {
                    Text("\(viewModel.fixtureToAdd.colorSysEnum.getColorSystemName())")
                }
                Section(header: Text("DMX Number Modes || Min || Max")) {
                    HStack {
                        Text("\(viewModel.fixtureToAdd.dmxModes)")
                        Spacer()
                        Divider()
                        Spacer()
                        Text("\(viewModel.fixtureToAdd.minDmx)")
                        Spacer()
                        Divider()
                        Spacer()
                        Text("\(viewModel.fixtureToAdd.minDmx)")
                    }
                }
                Section(header: Text("Weight")) {
                    Text("\(viewModel.fixtureToAdd.weight)")
                }
                Section(header: Text("Comment")) {
                    Text("\(viewModel.fixtureToAdd.comment)")
                }
            }
            VStack {
                Text("\(viewModel.message)")
                    .multilineTextAlignment(.center)
                    .font(.title2)
                Button {
                    viewModel.addFixture()
                } label: {
                    Text("store")
                        .font(.title2)
                }

            }
            .padding()
        }
        
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
