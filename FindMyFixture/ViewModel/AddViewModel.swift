//
//  AddViewModel.swift
//  FindMyFixture
//
//  Created by Student on 11.06.21.
//

import Foundation
import SwiftUI

class AddViewModel: ObservableObject {
    

        
    @ObservedObject var fixtureToAdd = Fixture(id: 1, name: "", producer: "", power: 0, powerLight: 0, goboWheels: 0, prisms: 0, minZoom: 0.0, maxZoom: 0.0, dmxModes: 0, minDmx: 0, maxDmx: 0, weight: 0, comment: "", imageURL: "http://hasashi.bplaced.net/findmyfixture/images/default_bulb.png", colorSysEnum: .cmy, lampType: .headmover)
        
        @Published var message: String = ""
        
        lazy var sectionViewModel = [
            AddSectionViewModel(title: "Name", items: [
                AddSectionItemViewModel(title: "enter name", sectionItemType: .textField, formatter: StringTextFieldFormatter(), value: $fixtureToAdd.name)
            ]),
            AddSectionViewModel(title: "Producer", items: [
                AddSectionItemViewModel(title: "enter producer", sectionItemType: .textField, formatter: StringTextFieldFormatter(), value: $fixtureToAdd.producer)
            ]),
            AddSectionViewModel(title: "Total Power || Light Source Power)", items: [
                AddSectionItemViewModel(title: "enter power", sectionItemType: .textField, formatter: IntTextFieldFormatter(), value: $fixtureToAdd.power),
                AddSectionItemViewModel(title: "enter light power", sectionItemType: .textField, formatter: IntTextFieldFormatter(), value: $fixtureToAdd.powerLight)
            ]),
            AddSectionViewModel(title: "Lamp Type", items: [
                AddSectionItemViewModel(title: "", sectionItemType: .picker, formatter: EnumTextFieldFormatter(), value: $fixtureToAdd.lampType)
            ]),
            AddSectionViewModel(title: "Number Gobo Wheels || Number Prism Wheels", items: [
                AddSectionItemViewModel(title: "enter gobo wheels", sectionItemType: .textField, formatter: IntTextFieldFormatter(), value: $fixtureToAdd.goboWheels),
                AddSectionItemViewModel(title: "enter prisms", sectionItemType: .textField, formatter: IntTextFieldFormatter(), value: $fixtureToAdd.prisms),
            ]),
            AddSectionViewModel(title: "Zoom Min || Max", items: [
                AddSectionItemViewModel(title: "enter min zoom", sectionItemType: .textField, formatter: FloatTextFieldFormatter(), value: $fixtureToAdd.minZoom),
                AddSectionItemViewModel(title: "enter max zoom", sectionItemType: .textField, formatter: FloatTextFieldFormatter(), value: $fixtureToAdd.maxZoom),
            ]),
            AddSectionViewModel(title: "Color Mix System", items: [
                AddSectionItemViewModel(title: "", sectionItemType: .picker, formatter: EnumTextFieldFormatter(), value: $fixtureToAdd.colorSysEnum),
            ]),
            AddSectionViewModel(title: "DMX Number Modes || Min Channel || Max Channel", items: [
                AddSectionItemViewModel(title: "enter dmx modes", sectionItemType: .textField, formatter: IntTextFieldFormatter(), value: $fixtureToAdd.dmxModes),
                AddSectionItemViewModel(title: "enter min dmx", sectionItemType: .textField, formatter: IntTextFieldFormatter(), value: $fixtureToAdd.minDmx),
                AddSectionItemViewModel(title: "enter max dmx", sectionItemType: .textField, formatter: IntTextFieldFormatter(), value: $fixtureToAdd.maxDmx),
            ]),
            AddSectionViewModel(title: "Weight", items: [
                AddSectionItemViewModel(title: "enter weight", sectionItemType: .textField, formatter: IntTextFieldFormatter(), value: $fixtureToAdd.weight),
            ]),
            AddSectionViewModel(title: "Comment", items: [
                AddSectionItemViewModel(title: "enter comment", sectionItemType: .textField, formatter: StringTextFieldFormatter(), value: $fixtureToAdd.comment),
            ])
        ]
    
    
    public func addFixture(completion: @escaping (Bool) -> Void) {
        Repository.shared.addFixture(with: fixtureToAdd) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.message = response.message
                    completion(true)
                case .failure(let error):
                    self.message = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
    
    
    
}
