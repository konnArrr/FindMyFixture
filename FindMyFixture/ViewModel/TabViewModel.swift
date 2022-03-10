//
//  TabViewModel.swift
//  FindMyFixture
//
//  Created by Student on 10.06.21.
//

import Foundation


class TabViewModel: ObservableObject {
    
    @Published var user: User = User(id: 0, username: "default", password: "default", adminRights: 0, registerDate: "")

    
    public func getCurrentUser(id: Int) {
        Repository.shared.getUser(by: UserBodyDataModel(id: String(id))) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.user = user
                }
            case .failure(let error):
                break
            }
        }
    }
    
    
    
    
}
