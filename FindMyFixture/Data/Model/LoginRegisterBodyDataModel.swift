//
//  LoginBodyDataModel.swift
//  FindMyFixture
//
//  Created by Konstantin Schirmer on 02.03.22.
//

import Foundation
import SwiftUI

class LoginRegisterBodyDataModel: BodyDataModel {
    
    let username: String
    let password: String
    
    internal init(username: String, password: String) {
        
        self.username = username
        self.password = password
    }
    
    enum CodeKeys: CodingKey
    {
        case username
        case password
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodeKeys.self)
        username = try container.decode (String.self, forKey: .username)
        password = try container.decode (String.self, forKey: .password)
    }
    
    func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodeKeys.self)
        try container.encode (username, forKey: .username)
        try container.encode (password, forKey: .password)
    }
  
}
