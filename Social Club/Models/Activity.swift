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
    var date: Date = Date()
    var id = UUID()
    var hourMin = DateComponents()
    var peopleNeeded: Int
    var dorm: Dorm?
    var dateComponentsTill = DateComponents()
    
    var ratings: [Rating] = []
    
    enum Dorm: String, CaseIterable, Identifiable {
        case Blackwell = "Blackwell Hall"
        case Unit1 = "Unit 1"
        case Unit2 = "Unit 2"
        case Unit3 = "Unit 3"
        case Clark_Kerr = "Clark Kerr"
        
        var id: String { rawValue }
    }
    
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
    init(description: String, location: String, creator: User, atendees: [User]?, date: Date?, peopleNeeded: Int, dorm: Dorm) {
        self.description = description
        self.location = location
        self.creator = creator
        self.atendees = atendees
        self.date = date ?? Date.now
        self.peopleNeeded = peopleNeeded
        self.dorm = dorm
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
                return Text("\(String(unwrappedMinute))m ago")
                    .foregroundColor(.red)
            } else if (hour ?? 0) > -24 {
                let unwrappedMinute = abs(minute ?? 0)
                let unwrappedHour = abs(hour ?? 0)
                return Text("\(String(unwrappedHour))h \(unwrappedMinute)m ago")
                    .foregroundColor(.red)
            } else if (hour ?? 0) < -24 {
                let unwrappedHour = abs(hour ?? 0)
                let day = unwrappedHour % 24
                return Text("\(day)d ago")
                    .foregroundColor(.red)
            } else {
                return Text("Error getting date")
            }
        } else {
            // time must be in future
            if hour == 0 {
                let unwrappedMinute = abs(minute ?? 0)
                return Text("In \(String(unwrappedMinute))m")
                    .foregroundColor(.green)
                    
            } else if (hour ?? 0) < 24 {
                let unwrappedMinute = (minute ?? 0)
                let unwrappedHour = (hour ?? 0)
                return Text("In \(String(unwrappedHour))h \(unwrappedMinute) m")
                    .foregroundColor(.green)
            } else if (hour ?? 0) > 24 {
                let unwrappedHour = (hour ?? 0)
                return Text("In \(unwrappedHour % 24)d")
                    .foregroundColor(.green)
            } else {
                return Text("Error getting date")
            }
        }
    }
    
    var timeTillActivityString: String {
        let dateComponents = self.getDateDiff()
        let hour = dateComponents?.hour
        let minute = dateComponents?.minute
        
        // if either time is negative, the activity must be in the past
        if (hour ?? 0) < 0 || (minute ?? 0) < 0 {
            if hour == 0 {
                let unwrappedMinute = abs(minute ?? 0)
                return "\(String(unwrappedMinute))m ago"
            } else if (hour ?? 0) > -24 {
                let unwrappedMinute = abs(minute ?? 0)
                let unwrappedHour = abs(hour ?? 0)
                return "\(String(unwrappedHour))h \(unwrappedMinute)m ago"
            } else if (hour ?? 0 ) < -24 {
                let unwrappedHour = abs(hour ?? 0)
                return "\(unwrappedHour % 24)d ago"
            } else {
                return "Error getting date"
            }
        } else {
            // time must be in future
            if hour == 0 {
                let unwrappedMinute = abs(minute ?? 0)
                return "In \(String(unwrappedMinute))m"
            } else if (hour ?? 0) < 24 {
                let unwrappedMinute = (minute ?? 0)
                let unwrappedHour = (hour ?? 0)
                return "In \(String(unwrappedHour))h \(unwrappedMinute)m"
            } else if (hour ?? 0) > 24 {
                let unwrappedHour = (hour ?? 0)
                return "In \(unwrappedHour % 24)d"
            } else {
                return "Error getting date"
            }
        }
    }
}
