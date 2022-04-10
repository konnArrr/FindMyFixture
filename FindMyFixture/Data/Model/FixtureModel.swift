//
//  FixtureModel.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation


class Fixture: BodyDataModel, Equatable, ObservableObject{

 
    // change to DTO Object and struct
    var id: Int
    @Published var name: String
    @Published var producer: String
    @Published var power: Int
    @Published var powerLight: Int
    @Published var goboWheels: Int
    @Published var prisms: Int
    @Published var minZoom: Double
    @Published var maxZoom: Double
    @Published var dmxModes: Int
    @Published var minDmx: Int
    @Published var maxDmx: Int
    @Published var weight: Int
    @Published var comment: String
    @Published var imageURL: String
    @Published var colorSysEnum: ColorSystem
    @Published var lampType: LampType
    
    
    
    internal init(id: Int, name: String, producer: String, power: Int, powerLight: Int, goboWheels: Int, prisms: Int, minZoom: Double, maxZoom: Double, dmxModes: Int, minDmx: Int, maxDmx: Int, weight: Int, comment: String, imageURL: String, colorSysEnum: ColorSystem, lampType: LampType) {
        self.id = id
        self.name = name
        self.producer = producer
        self.power = power
        self.powerLight = powerLight
        self.goboWheels = goboWheels
        self.prisms = prisms
        self.minZoom = minZoom
        self.maxZoom = maxZoom
        self.dmxModes = dmxModes
        self.minDmx = minDmx
        self.maxDmx = maxDmx
        self.weight = weight
        self.comment = comment
        self.imageURL = imageURL
        self.colorSysEnum = colorSysEnum
        self.lampType = lampType
    }
    
    
    
    
    enum CodeKeys: CodingKey {
        case id
        case name
        case producer
        case power
        case powerLight
        case headMover
        case goboWheels
        case prisms
        case minZoom
        case maxZoom
        case colorSystem
        case dmxModes
        case minDmx
        case maxDmx
        case weight
        case comment
        case imageURL
    }
    
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodeKeys.self)
        id = try container.decode(Int.self, forKey:.id)
        name = try container.decode(String.self, forKey:.name)
        producer = try container.decode(String.self, forKey:.producer)
        power = try container.decode(Int.self, forKey:.power)
        powerLight = try container.decode(Int.self, forKey:.powerLight)
        goboWheels = try container.decode(Int.self, forKey:.goboWheels)
        prisms = try container.decode(Int.self, forKey:.prisms)
        minZoom = try container.decode(Double.self, forKey:.minZoom)
        maxZoom = try container.decode(Double.self, forKey:.maxZoom)
        dmxModes = try container.decode(Int.self, forKey:.dmxModes)
        minDmx = try container.decode(Int.self, forKey:.minDmx)
        maxDmx = try container.decode(Int.self, forKey:.maxDmx)
        weight = try container.decode(Int.self, forKey:.weight)
        comment = try container.decode(String.self, forKey:.comment)
        imageURL = try container.decode(String.self, forKey:.imageURL)
        colorSysEnum = ColorSystem(rawValue: try container.decode(Int.self, forKey:.colorSystem)) ?? .cmy
        lampType = LampType(rawValue: try container.decode(Int.self, forKey:.headMover)) ?? .nonHeadMover
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodeKeys.self)
        try container.encode (id, forKey: .id)
        try container.encode (name, forKey: .name)
        try container.encode (producer, forKey: .producer)
        try container.encode (power, forKey: .power)
        try container.encode (powerLight, forKey: .powerLight)
        try container.encode (lampType.rawValue, forKey: .headMover)
        try container.encode (goboWheels, forKey: .goboWheels)
        try container.encode (prisms, forKey: .prisms)
        try container.encode (minZoom, forKey: .minZoom)
        try container.encode (maxZoom, forKey: .maxZoom)
        try container.encode (colorSysEnum.rawValue, forKey: .colorSystem)
        try container.encode (dmxModes, forKey: .dmxModes)
        try container.encode (minDmx, forKey: .minDmx)
        try container.encode (maxDmx, forKey: .maxDmx)
        try container.encode (weight, forKey: .weight)
        try container.encode (comment, forKey: .comment)
        try container.encode (imageURL, forKey: .imageURL)
    }
    
    static func == (lhs: Fixture, rhs: Fixture) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}


enum LampType: Int, PickerTypeProtocol {
    
    var id: String { return UUID().uuidString }
    
    typealias PickerType = LampType
    
    func allCases() -> [PickerType] {
        return LampType.allCases
    }
    
    
    case nonHeadMover = 0
    case headmover = 1
    
    func getName() -> String {
        switch self {
        case .nonHeadMover:
            return "Static"
        case .headmover:
            return "Headmover"
        }
    }
    
}


enum ColorSystem: Int,  PickerTypeProtocol {
    
    var id: String { return UUID().uuidString }
    
    typealias PickerType = ColorSystem
    
    func allCases() -> [ColorSystem] {
        return ColorSystem.allCases
    }
    
    
    case cmy = 1
    case rgb = 2
    case rgbw = 3
    case rgba = 4
    case rgbaw = 5
    case rgbawuv = 6
    
    func getName() -> String {
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
