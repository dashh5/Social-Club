//
//  UserData.swift
//  Social Club
//
//  Created by Alex M on 1/9/22.
//

import Foundation
import SwiftUI

class UserData: ObservableObject {
    // replace with firebase data
    @Published var users = [User]()
    @Published var currentUser: User
    
    init() {
        currentUser = User(name: "TestUser", phone: 123, activities: nil, instagram: "")
        users.append(currentUser)
    }
    
    func index(of user: User) -> Int? {
        for index in users.indices {
            if users[index].id == user.id {
                return index
            }
        }
        return nil
    }
    
    
}
