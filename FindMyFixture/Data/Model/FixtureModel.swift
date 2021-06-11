//
//  FixtureModel.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation


struct Fixture: Codable {
//    let id: Int
//    let name, producer: String
//    let power, powerLight, headMover, goboWheels: Int
//    let prisms: Int
//    let minZoom, maxZoom: Double
//    let colorSystem, dmxModes, minDmx, maxDmx: Int
//    let weight: Int
//    let comment: String
//    let imageURL: String
    
    var id: Int
    var name, producer: String
    var power, powerLight, headMover, goboWheels: Int
    var prisms: Int
    var minZoom, maxZoom: Double
    var colorSystem, dmxModes, minDmx, maxDmx: Int
    var weight: Int
    var comment: String
    var imageURL: String
    
    
    var colorSysEnum: ColorSystem {
        return ColorSystem(rawValue: colorSystem) ?? .cmy
    }
    
    var lampType: LampType {
        return LampType(rawValue: headMover) ?? .nonHeadMover
    }
    
}


enum LampType: Int, CaseIterable {
    case nonHeadMover = 0
    case headmover = 1
    
    func getLampTypeName() -> String {
        switch self {
        case .nonHeadMover:
            return "Static"
        case .headmover:
            return "Headmover"
        }
    }
    
}


enum ColorSystem: Int, CaseIterable {
    case cmy = 1
    case rgb = 2
    case rgbw = 3
    case rgba = 4
    case rgbaw = 5
    case rgbawuv = 6
    
    func getColorSystemName() -> String {
        switch self {
        case .cmy:
            return "\(ColorSystem.cmy)"
        case .rgb:
            return "\(ColorSystem.rgb)"
        case .rgbw:
            return "\(ColorSystem.rgbw)"
        case .rgba:
            return "\(ColorSystem.rgba)"
        case .rgbaw:
            return "\(ColorSystem.rgbaw)"
        case .rgbawuv:
            return "\(ColorSystem.rgbawuv)"
        }
    }
}
