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
        let activity1 = Activity(description: "Need another for spikeball 3v3", location: "Ur mom", creator: User(name: "Yeet", phone: 123, instagram: "Monke"))
        let activity2 = Activity(description: "Going out to SF with group of three seniors (all guys) want one more.", location: "Ur dad", creator: User(name: "Yeet2", phone: 456, instagram: "Monke2"))
        let activity3 = Activity(description: "Movie night on the deck in blackwell! All welcome", location: "Ur uncle", creator: User(name: "Yeet3", phone: 789, instagram: "Monke3"))
        self.activities = [activity1, activity2, activity3]
    }
}
