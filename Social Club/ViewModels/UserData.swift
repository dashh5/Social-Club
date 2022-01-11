//
//  UserData.swift
//  Social Club
//
//  Created by Alex M on 1/9/22.
//

import Foundation

class UserData: ObservableObject {
    init() {
        currentUser = User(name: "Alex", phone: 123, instagram: "YEETNUT")
    }
    
    // replace with firebase data
    var users = [User]()
    
    var currentUser: User
    
    func addUser() {
        
    }
    
    func delUser() {
        
    }
}