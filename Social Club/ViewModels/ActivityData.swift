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
        let tempDate = Date.now.addingTimeInterval(-100000)
        
        let activity1 = Activity(description: "Need another for spikeball 3v3", location: "Memorial Glade", creator: User(name: "Michael Jordan", phone: 123, activities: nil, instagram: "Monke", profilePicName: "obama", year: User.Year.junior), atendees: [User()], date: Date.now.addingTimeInterval(130), peopleNeeded: 2, dorm: Activity.Dorm.Unit2)
        let activity2 = Activity(description: "Going out to SF with group of three seniors (all guys) want one more.", location: "Haas Pavillian", creator: User(name: "Peter Griffin", phone: 456, activities: nil, instagram: "Monke2", profilePicName: "peter", year: User.Year.freshman), atendees: nil, date: Date.now.addingTimeInterval(2000), peopleNeeded: 2, dorm: Activity.Dorm.Blackwell)
        let activity3 = Activity(description: "Movie night on the deck in blackwell! We have meat on the BBQ and Borat playing!", location: "2nd floor Blackwell deck", creator: User(name: "Oscar Martinez", phone: 789, activities: nil, instagram: "Monke3", profilePicName: "oscar", year: User.Year.senior), atendees: [User()], date: tempDate, peopleNeeded: 4)
        self.activities = [activity1, activity2, activity3]
    }
    
    func getActivities() -> [Activity] {
        return activities.sorted(by: { $0.date < $1.date })
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
