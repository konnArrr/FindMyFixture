//
//  GetUserDataModel.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 02.03.22.
//

import Foundation

class UserBodyDataModel: BodyDataModel {
    
    let id: String
    
    init(id: String) {
        self.id = id
        super.init()
    }
    
    
    
    enum CodeKeys: CodingKey
    {
        case id
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodeKeys.self)
        id = try container.decode (String.self, forKey: .id)
        super.init()
    }
    
    override func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodeKeys.self)
        try container.encode (id, forKey: .id)
    }

    
    
}
