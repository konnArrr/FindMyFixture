//
//  SectionView.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 10.03.22.
//

import SwiftUI

struct SectionView: View {
    let sectionViewModel: AddSectionViewModel
    
    
    
    var body: some View {
        Section(header: Text(sectionViewModel.title)) {
            ForEach(sectionViewModel.items.indices) { index in
                let item = sectionViewModel.items[index]
                
                if item.sectionItemType == .textField {
                    
                    if let item = item as? AddSectionItemViewModel<StringTextFieldFormatter>{
                        SectionItemTextFieldView(title: item.title, value: item.value, formatter: item.formatter)
                    }
                    if let item = item as? AddSectionItemViewModel<FloatTextFieldFormatter>{
                        SectionItemTextFieldView(title: item.title, value: item.value, formatter: item.formatter)
                    }
                    if let item = item as? AddSectionItemViewModel<IntTextFieldFormatter>{
                        SectionItemTextFieldView(title: item.title, value: item.value, formatter: item.formatter)
                    }
                }else {
                    if let item = item as? AddSectionItemViewModel<EnumTextFieldFormatter<LampType>>{
                        SectionItemPickerView(pickerType: .headmover , value: item.value)
                    }
                    if let item = item as? AddSectionItemViewModel<EnumTextFieldFormatter<ColorSystem>>{
                        SectionItemPickerView(pickerType: .cmy , value: item.value)
                    }
                }
            }
        }
    }
}

struct SectionItemPickerView<T : PickerTypeProtocol>: View   {
    
    @State var pickerType: T
    let value: Binding<T>
    var body: some View {
        
        Picker(selection: Binding(get: {
            return self.value.wrappedValue
        }, set: { pickerType in
            self.pickerType = pickerType
            self.value.wrappedValue = pickerType
        }), label: Text("")) {
            ForEach(T.allCases, id: \.self) {
                Text($0.getName()).tag($0)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .onChange(of: pickerType) { (colorS) in
            
        }
    }
}

struct SectionItemTextFieldView<Formatter: TextFieldFormatter>: View {
   
    let title: String
    let value: Binding<Formatter.Value>
    let formatter: Formatter
    
    public var body: some View {
        TextField(title, text: Binding(get: {
            if self.isEditing {
                return self.editingValue
            } else {
                return self.formatter.displayString(for: self.value.wrappedValue)
            }
        }, set: { string in
            self.editingValue = string
            self.value.wrappedValue = self.formatter.value(from: string)
        }), onEditingChanged: { isEditing in
            self.isEditing = isEditing
            self.editingValue = self.formatter.editingString(for: self.value.wrappedValue)
        })
            .keyboardWithType(type: value)
    }
    
    @State private var isEditing: Bool = false
    @State private var editingValue: String = ""
}


extension View {
    
    func keyboardWithType(type: Any) -> some View {
        return self.modifier(KeyboardModifier(type: type))
    }
    
}


struct KeyboardModifier: ViewModifier {
    
    let type: Any
    
    func body(content: Content) -> some View {
        var body: some View {
            if type is Binding<Int> {
                return content
                    .keyboardType(.numberPad)
            } else if type is Binding<Double> {
                return content
                    .keyboardType(.decimalPad)
            } else {
                return content
                    .keyboardType(.default)
            }
        }
        return body
    }
}



