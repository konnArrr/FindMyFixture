//
//  TabViewModel.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation


class TabViewModel: ObservableObject {
    
    @Published var user: User = User(id: 0, username: "default", password: "default", adminRights: 0, registerDate: "")
    
    private let userLoader = UserLoader()
    
    public func getCurrentUser(id: Int) {
        userLoader.getUserBy(userId: id) { (user) in
            self.user = user
        }
    }
    
    
    
    
}
