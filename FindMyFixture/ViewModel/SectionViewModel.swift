//
//  SectionViewModel.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 10.03.22.
//

import Foundation
import SwiftUI


struct AddSectionViewModel {
    let title: String
    var items: [AddSectionItemProtocol]
}

protocol AddSectionItemProtocol {
    
    func getValue() -> Self
    var sectionItemType: AddSectionItemType {get set}
}

enum AddSectionItemType {
    case textField, picker
}

struct AddSectionItemViewModel<Formatter: TextFieldFormatter>: AddSectionItemProtocol {
    
    
    
    func getValue() -> AddSectionItemViewModel<Formatter> {
        return self
    }
    
    
    let title: String
    var sectionItemType: AddSectionItemType
    let formatter: Formatter
    let value: Binding<Formatter.Value>
    
}



public protocol TextFieldFormatter: Hashable {
    associatedtype Value
    func displayString(for value: Value) -> String
    func editingString(for value: Value) -> String
    func value(from string: String) -> Value
    
}


struct StringTextFieldFormatter: TextFieldFormatter {
    typealias Value = String
    
    func displayString(for value: String) -> String {
        return value
    }
    
    func editingString(for value: String) -> String {
        return value
    }
    
    func value(from string: String) -> String {
        return string
    }
}


struct FloatTextFieldFormatter: TextFieldFormatter {
    typealias Value = Double
    
    func displayString(for value: Double) -> String {
        return NumberFormatter().string(for: value) ?? ""
    }
    
    func editingString(for value: Double) -> String {
        return NumberFormatter().string(for: value) ?? ""
    }
    
    func value(from string: String) -> Double {
        return  NumberFormatter().number(from: string)?.doubleValue ?? 0.0
    }
}


struct IntTextFieldFormatter: TextFieldFormatter {
    typealias Value = Int
    
    func displayString(for value: Int) -> String {
        return NumberFormatter().string(for: value) ?? ""
    }
    
    func editingString(for value: Int) -> String {
        return NumberFormatter().string(for: value) ?? ""
    }
    
    func value(from string: String) -> Int {
        return  NumberFormatter().number(from: string)?.intValue ?? 0
    }
}


struct EnumTextFieldFormatter<T : PickerTypeProtocol>: TextFieldFormatter {
    
    
    typealias Value = T
    
    func displayString(for value: T) -> String {
        return value.getName()
    }
    
    func editingString(for value: T) -> String {
        return value.getName()
    }
    
    func value(from string: String) -> T {
        return T.self as! T
    }
}

protocol PickerTypeProtocol: Identifiable, Hashable, CaseIterable where AllCases == Array<Self> {
    associatedtype PickerType
    func getName() -> String
    func allCases() -> [PickerType]
}




