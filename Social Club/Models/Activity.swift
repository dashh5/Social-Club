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
    var date: Date = Date.now
    var id = UUID()
    var hourMin = DateComponents()
    
    init() {
        self.description = ""
        self.location = ""
        self.creator = User()
        setDateMins()
    }
    
    init(description: String, location: String, creator: User, atendees: [User]?, date: Date?) {
        self.description = description
        self.location = location
        self.creator = creator
        self.atendees = atendees
        self.date = date ?? Date.now
        setDateMins()
    }
    
    func update(to activity: Activity) {
        // update activity in DB
    }
    
    mutating func setDateMins() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: self.date)
        self.hourMin = components
    }
    
    func getDateDiff() -> String {
        let diff = Calendar.current.dateComponents([.minute], from: self.date, to: Date.now)
        return DateComponentsFormatter().string(from: diff)!
    }
}
