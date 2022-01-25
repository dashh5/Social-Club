//
//  Activity.swift
//  Social Club
//
//  Created by Alex M on 1/9/22.
//

import Foundation
import SwiftUI

struct Activity: Identifiable {
    var description: String
    var location: String // maybe location data type here?
    var creator: User
    var atendees: [User]?
    var date: Date = Date.now
    var id = UUID()
    var hourMin = DateComponents()
    var peopleNeeded: Int
    
    init() {
        self.description = ""
        self.location = ""
        self.creator = User()
        self.peopleNeeded = 0
        setDateMins()
    }
    
    init(description: String, location: String, creator: User, atendees: [User]?, date: Date?, peopleNeeded: Int) {
        self.description = description
        self.location = location
        self.creator = creator
        self.atendees = atendees
        self.date = date ?? Date.now
        self.peopleNeeded = peopleNeeded
        setDateMins()
    }
    
    mutating func setDateMins() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: self.date)
        self.hourMin = components
    }
    
    func getDateDiffStr() -> String {
        let diff = Calendar.current.dateComponents([.minute], from: Date.now, to: self.date)
        return DateComponentsFormatter().string(from: diff)!
    }
    
    func getDateDiff() -> DateComponents? {
        return Calendar.current.dateComponents([.hour, .minute], from: Date.now, to: self.date)
    }
    
    // show calculated time to or from activity: i.e. "In 1 hour 20 minutes"
    var timeTillActivityView: some View {
        let dateComponents = self.getDateDiff()
        let hour = dateComponents?.hour
        let minute = dateComponents?.minute
        
        // if either time is negative, the activity must be in the past
        if (hour ?? 0) < 0 || (minute ?? 0) < 0 {
            if hour == 0 {
                let unwrappedMinute = abs(minute ?? 0)
                return Text("\(String(unwrappedMinute)) minute\(unwrappedMinute == 1 ? "" : "s") ago")
                    .foregroundColor(.red)
            } else {
                let unwrappedMinute = abs(minute ?? 0)
                let unwrappedHour = abs(hour ?? 0)
                return Text("\(String(unwrappedHour)) hour\(unwrappedHour == 1 ? "" : "s") \(unwrappedMinute) minute\(unwrappedMinute == 1 ? "" : "s") ago")
                    .foregroundColor(.red)
            }
        } else {
            // time must be in future
            if hour == 0 {
                let unwrappedMinute = abs(minute ?? 0)
                return Text("In \(String(unwrappedMinute)) minute\(unwrappedMinute == 1 ? "" : "s")")
                    
            } else {
                let unwrappedMinute = (minute ?? 0)
                let unwrappedHour = (hour ?? 0)
                return Text("In \(String(unwrappedHour)) hour\(unwrappedHour == 1 ? "" : "s") \(unwrappedMinute) minute\(unwrappedMinute == 1 ? "" : "s")")
            }
        }
    }
}
