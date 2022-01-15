//
//  ActivityData.swift
//  Social Club
//
//  Created by Alex M on 1/9/22.
//

import Foundation

class ActivityData: ObservableObject {
    var activities: [Activity]
    init() {
        let tempDate = Date.distantPast
        let activity1 = Activity(description: "Need another for spikeball 3v3", location: "Memorial Glade", creator: User(name: "Obama", phone: 123, activities: nil, instagram: "Monke"), atendees: [User()], date: Date.now)
        let activity2 = Activity(description: "Going out to SF with group of three seniors (all guys) want one more.", location: "Haas Pavillian", creator: User(name: "James", phone: 456, activities: nil, instagram: "Monke2"), atendees: nil, date: Date.now)
        let activity3 = Activity(description: "Movie night on the deck in blackwell! All welcome", location: "2nd floor Blackwell deck", creator: User(name: "Oscar", phone: 789, activities: nil, instagram: "Monke3"), atendees: [User()], date: tempDate)
        self.activities = [activity1, activity2, activity3]
    }
    
    func addActivity(activity: Activity) {
        activities.append(activity)
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
