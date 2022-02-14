//
//  Rating.swift
//  Berkeley Social Club
//
//  Created by Alex M on 1/29/22.
//

import Foundation

struct Rating: Identifiable {
    enum Rate: String, CaseIterable, Identifiable, Hashable {
        case one = "⭐️"
        case two = "⭐️⭐️"
        case three = "⭐️⭐️⭐️"
        case four = "⭐️⭐️⭐️⭐️"
        case five = "⭐️⭐️⭐️⭐️⭐️"
        var id: String { rawValue }
    }
    
    var ratee: User
    var activity: Activity
    var rater: User
    var rating: Rate?
    
    var id = UUID()
}
