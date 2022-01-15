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
    var activities = [Activity]()
    var instagram: String?
    var dateJoined = Date.now
    var id = UUID()
    
    init() {
        self.name = ""
        self.phone = 0
    }
    init(name: String, phone: Int, activities: [Activity]?, instagram: String?) {
        self.name = name
        self.phone = phone
        if let activitiesReal = activities {
            self.activities = activitiesReal
        } else {
            self.instagram = instagram
        }
    }
    
    func joinActivity(activity: Activity) {
        
    }
}
