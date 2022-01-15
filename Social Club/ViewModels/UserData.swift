//
//  UserData.swift
//  Social Club
//
//  Created by Alex M on 1/9/22.
//

import Foundation

class UserData: ObservableObject {
    init() {
        currentUser = User(name: "TestUser", phone: 123, activities: nil, instagram: "")
        users.append(currentUser)
    }
    
    // replace with firebase data
    var users = [User]()
    
    var currentUser: User
}
