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
                    TextField("enter name", text: $viewModel.fixture.name)
                }
                Section(header: Text("Producer")) {
                    TextField("enter producer", text: $viewModel.fixture.producer)
                }
                Section(header: Text("Total Power || Light Source Power)")) {
                    HStack {
                        TextField("enter power", text: $power)
                            .keyboardType(.numberPad)
                            .onReceive(Just(power)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.power = filtered
                                            }
                            }
                            .onChange(of: power) { (power) in
                                viewModel.fixture.power = Int(power) ?? 0
                            }
                        Divider()
                        TextField("enter light power", text: $powerLight)
//                            .keyboardType(.numberPad)
                            .onReceive(Just(powerLight)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.powerLight = filtered
                                            }
                            }
                            .onChange(of: powerLight) { (powerL) in
                                viewModel.fixture.powerLight = Int(powerL) ?? 0
                            }
                    }
                }
                Section(header: Text("Lamp Type")) {
                    Picker(selection: $lamptype, label: Text("")) {
                        ForEach(LampType.allCases, id: \.self) {
                            Text($0.getLampTypeName()).tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: lamptype) { (lamptype) in
                        viewModel.fixture.headMover = lamptype.rawValue
                    }
                }
                Section(header: Text("Number Gobo Wheels || Number Prism Wheels")) {
                    HStack {
                        TextField("enter gobo wheels", text: $goboWheels)
//                            .keyboardType(.numberPad)
                            .onReceive(Just(goboWheels)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.goboWheels = filtered
                                            }
                            }
                            .onChange(of: goboWheels) { input in
                                viewModel.fixture.goboWheels = Int(input) ?? 0
                            }
                        Divider()
                        TextField("enter prisms", text: $prisms)
//                            .keyboardType(.numberPad)
                            .onReceive(Just(prisms)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.prisms = filtered
                                            }
                            }
                            .onChange(of: prisms) { (input) in
                                viewModel.fixture.prisms = Int(input) ?? 0
                            }
                    }
                }
                Section(header: Text("Zoom Min || Max")) {
                    HStack {
                        TextField("enter min zoom", text: $minZoom)
//                            .keyboardType(.numberPad)
                            .onReceive(Just(minZoom)) { newValue in
                                            let filtered = newValue.filter { "0123456789.".contains($0) }
                                            if filtered != newValue {
                                                self.minZoom = filtered
                                            }
                            }
                            .onChange(of: minZoom) { input in
                                viewModel.fixture.minZoom = Double(input) ?? 0
                            }
                        Divider()
                        TextField("enter max zoom", text: $maxZoom)
//                            .keyboardType(.numberPad)
                            .onReceive(Just(maxZoom)) { newValue in
                                            let filtered = newValue.filter { "0123456789.".contains($0) }
                                            if filtered != newValue {
                                                self.maxZoom = filtered
                                            }
                            }
                            .onChange(of: maxZoom) { (input) in
                                viewModel.fixture.maxZoom = Double(input) ?? 0
                            }
                    }
                }
                Section(header: Text("Color Mix System")) {
                    Picker(selection: $colorSys, label: Text("")) {
                        ForEach(ColorSystem.allCases, id: \.self) {
                            Text($0.getColorSystemName()).tag($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .onChange(of: colorSys) { (colorS) in
                        viewModel.fixture.colorSystem = colorS.rawValue
                    }
                }
                Section(header: Text("DMX Number Modes || Min Channel || Max Channel")) {
                    HStack {
                        TextField("enter dmx modes", text: $dmxModes)
//                            .keyboardType(.numberPad)
                            .onReceive(Just(dmxModes)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.dmxModes = filtered
                                            }
                            }
                            .onChange(of: dmxModes) { input in
                                viewModel.fixture.dmxModes = Int(input) ?? 0
                            }
                        Divider()
                        TextField("enter min dmx", text: $minDmx)
//                            .keyboardType(.numberPad)
                            .onReceive(Just(minDmx)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.minDmx = filtered
                                            }
                            }
                            .onChange(of: minDmx) { input in
                                viewModel.fixture.minDmx = Int(input) ?? 0
                            }
                        Divider()
                        TextField("enter max dmx", text: $maxDmx)
//                            .keyboardType(.numberPad)
                            .onReceive(Just(maxDmx)) { newValue in
                                            let filtered = newValue.filter { "0123456789".contains($0) }
                                            if filtered != newValue {
                                                self.maxDmx = filtered
                                            }
                            }
                            .onChange(of: maxDmx) { input in
                                viewModel.fixture.maxDmx = Int(input) ?? 0
                            }
                    }
                }
                Section(header: Text("Weight")) {
                    TextField("enter weight", text: $weight)
//                            .keyboardType(.numberPad)
                        .onReceive(Just(weight)) { newValue in
                                        let filtered = newValue.filter { "0123456789".contains($0) }
                                        if filtered != newValue {
                                            self.weight = filtered
                                        }
                        }
                        .onChange(of: weight) { input in
                            viewModel.fixture.weight = Int(input) ?? 0
                        }
                }
                Section(header: Text("Comment")) {
                    TextField("enter comment", text: $viewModel.fixture.comment)
                }
            }
            VStack {
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
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
