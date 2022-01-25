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
    var inActivity: Bool = false
    var karma: Int = 0
    
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
    
    mutating func joinActivity(activity: Activity) {
        self.activities.append(activity)
        self.inActivity = true
    }
    
    mutating func leaveActivity(activity: Activity) {
        self.inActivity = false
        if let index = index(of: activity) {
            self.activities.remove(at: index)
        }
    }
    
    // get the index for a particular user's activity
    func index(of activity: Activity) -> Int? {
        for i in activities.indices {
            if activities[i].id == activity.id {
                return i
            }
        }
        return nil
    }
}
