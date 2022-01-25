//
//  ActivityData.swift
//  Social Club
//
//  Created by Alex M on 1/9/22.
//

import Foundation
import SwiftUI

class ActivityData: ObservableObject {
    @Published var activities: [Activity]
    init() {
        let tempDate = Date.distantPast
        let activity1 = Activity(description: "Need another for spikeball 3v3", location: "Memorial Glade", creator: User(name: "Obama", phone: 123, activities: nil, instagram: "Monke"), atendees: [User()], date: Date.now, peopleNeeded: 2)
        let activity2 = Activity(description: "Going out to SF with group of three seniors (all guys) want one more.", location: "Haas Pavillian", creator: User(name: "James", phone: 456, activities: nil, instagram: "Monke2"), atendees: nil, date: Date.now, peopleNeeded: 0)
        let activity3 = Activity(description: "Movie night on the deck in blackwell! All welcome", location: "2nd floor Blackwell deck", creator: User(name: "Oscar", phone: 789, activities: nil, instagram: "Monke3"), atendees: [User()], date: tempDate, peopleNeeded: 1)
        self.activities = [activity1, activity2, activity3]
    }
    
    func removeActivity(activity: Activity) {
        if let indexToDelete = index(of: activity) {
            activities.remove(at: indexToDelete)
        } else {
            print("Activity could not be deleted")
        }
    }
    func addActivity(activity: Activity) {
        activities.append(activity)
    }
    
    func usersMostRecentActivity(for user: User) -> Activity? {
        let index = user.activities.endIndex - 1
        return user.activities[index]
    }
    
    func index(of activity: Activity) -> Int? {
        for i in activities.indices {
            if activities[i].id == activity.id {
                return i
            }
        }
        return nil
    }
}
