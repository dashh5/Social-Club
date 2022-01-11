//
//  User.swift
//  Social Club
//
//  Created by Alex M on 1/9/22.
//

import Foundation

struct User: Identifiable {
    var name: String
    var phone: Int
    var activities: [Activity]?
    var instagram: String?
    var id = UUID()
}
