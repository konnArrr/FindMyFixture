//
//  TabViewModel.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation


class TabViewModel: ObservableObject {
    
    @Published var user: User = User(id: 0, username: "default", password: "default", adminRights: 0, registerDate: "")
    
    private let userLoader = UserLoaderService()
    
    public func getCurrentUser(id: Int) {
        userLoader.getUserBy(userId: id) { (result) in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(_):
                // unused
                break
            }
        
        }
    }
    
    
    
    
}
