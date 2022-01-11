//
//  Activity.swift
//  Social Club
//
//  Created by Alex M on 1/9/22.
//

import Foundation

struct Activity: Identifiable {
    var description: String
    var location: String // maybe location data type here?
    var creator: User
    var atendees: [User]?
    var id = UUID()
}
