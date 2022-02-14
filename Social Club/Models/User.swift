//
//  User.swift
//  Social Club
//
//  Created by Alex M on 1/9/22.
//

import Foundation
import SwiftUI

struct User: Identifiable {
    var name: String
    var phone: Int
    var activities = [Activity]()
    var activitiesIn = [Activity]()
    var karma: Int = 0
    var bio: String?
    var year: Year
    var instagram: String?
    var id = UUID()
    var profilePic: Image = Image(systemName: "person.crop.circle.fill")
    
    enum Year: String, CaseIterable, Identifiable {
        case freshman = "Freshman"
        case sophomore = "Sophomore"
        case junior = "Junior"
        case senior = "Senior"
        case grad = "Grad Student"
        
        var id: String { self.rawValue }
    }
    
    init() {
        self.name = "Barack Obama"
        self.phone = 1234567890
        self.karma = Int.random(in: 1...100)
        self.year = Year.senior
    }
    
    
    init(name: String, phone: Int, activities: [Activity]?, instagram: String?, profilePicName: String, year: Year) {
        self.name = name
        self.phone = phone
        if let activitiesReal = activities {
            self.activities = activitiesReal
        } else {
            self.instagram = instagram
        }
        self.profilePic = Image(profilePicName)
        self.year = year
    }
    
    mutating func setBio(to bio: String) {
        self.bio = bio
    }
    
    func inThisActivity(activity: Activity) -> Bool {
        for joinedActivity in self.activitiesIn {
            if joinedActivity.id == activity.id {
                return true
            }
        }
        return false
    }

    
    func activitiesPosted() -> Int {
        var activitiesPosted: Int = 0
        for index in activities.indices {
            if activities[index].creator.id == self.id {
                activitiesPosted += 1
            }
        }
        return activitiesPosted
    }
    
    mutating func joinActivity(activity: Activity) {
        if index(of: activity) == nil {
            self.activities.append(activity)
        }
        self.activitiesIn.append(activity)
    }
    
    mutating func leaveActivity(activity: Activity) {
        var j = 0
        for i in activitiesIn.indices {
            if activitiesIn[i].id == activity.id {
                j = i
                break
            }
        }
        self.activitiesIn.remove(at: j)
    }
    
    var inActivity: Bool {
        if activitiesIn.count == 0 {
            return false
        } else {
            return true
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
