//
//  ActivityHistoryView.swift
//  Berkeley Social Club
//
//  Created by Alex M on 1/29/22.
//

import SwiftUI

struct ActivityHistoryView: View {
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject private var activityData: ActivityData
    
    @Binding var showCreateActivityButton: Bool
    
    var body: some View {
        NavigationView {
            if currentUser.activities.count == 0 {
                Text("Join some activities!")
                    .navigationTitle("Activity History")
            } else {
                List {
                    ForEach(currentUser.activities.sorted(by: { $0.date < $1.date })) { activity in
                        if activity.id == userActivities[userActivities.endIndex - 1].id && currentUser.inActivity {
                            NavigationLink("\(activity.description) (\(activity.timeTillActivityString))", destination: { PreviewActivityView(activity: binding(for: activity), showCreateActivityButton: $showCreateActivityButton) })
                                .foregroundColor(.purple)
                        } else {
                            NavigationLink("\(activity.description) (\(activity.timeTillActivityString))", destination: { PreviewActivityView(activity: binding(for: activity), showCreateActivityButton: $showCreateActivityButton) })
                        }
                    }
                }
                .navigationTitle("Activity History")
            }
        }
    }
    
    func binding(for activity: Activity) -> Binding<Activity> {
        guard let index = activityData.index(of: activity) else {
            fatalError("Activity not found")
        }
        return $activityData.activities[index]
    }
    
    var currentUser: User {
        return userData.currentUser
    }
    
    var userActivities: [Activity] {
        return currentUser.activities
    }
}

struct ActivityHistoryView_Previews: PreviewProvider {
    @State static var showCreateActivityButton = false
    
    
    static var previews: some View {
        ActivityHistoryView(showCreateActivityButton: $showCreateActivityButton).environmentObject(UserData())
            .environmentObject(ActivityData())
        
    }
}
