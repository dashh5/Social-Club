//
//  JoinedActivitySheet.swift
//  Berkeley Social Club
//
//  Created by Alex M on 1/16/22.
//

import SwiftUI

struct JoinedActivitySheet: View {
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject private var activityData: ActivityData
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var activity: Activity
    @Binding var showCreateActivityButton: Bool
    
    @State var alertLPresenting = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Posted by: \(activity.creator.name)")
                            .multilineTextAlignment(.leading)
                            .padding()
                        Spacer()
                    }
                    let diffString = activity.getDateDiffStr()
                    if (Int(diffString) ?? 1) < 1 {
                        Text("Just now")
                            .padding(.leading)
                    } else {
                        Text("\(diffString) minute\(Int(diffString) ?? 2 == 1 ? "" : "s") ago")
                            .padding(.leading)
                    }
                }
                List {
                    Section("Description") {
                        Text(activity.description)
                    }
                    Section("Location") {
                        Text(activity.location)
                    }
                    Section("Date & Time") {
                        Text(activity.date, format: .dateTime)
                    }
                    Section("People needed") {
                        Text(String(activity.peopleNeeded))
                    }
                    if activity.dorm != nil {
                        Section("Dorm") {
                            Text(activity.dorm?.rawValue ?? "")
                        }
                    }
                }
                Button(action: { leaveAlert() }) {
                    Design.redLongButtonLabel(text: "Leave Activity")
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .navigationTitle("Your Joined Activity")
            .navigationBarTitleDisplayMode(.large)
            .alert("Activity Left", isPresented: $alertLPresenting, actions: { Button("Cool", role: .cancel, action: {
                activityLeftActions()
            }) })
        }
    }
    
    func leaveAlert() {
        let currentUser = userData.currentUser
        let index = currentUser.activities.endIndex - 1
        if currentUser.inActivity == true && currentUser.activities[index].id == activity.id {
            alertLPresenting = true
        }
    }
    
    func activityLeftActions() {
        activity.peopleNeeded += 1
        userData.currentUser.leaveActivity(activity: activity)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct JoinedActivitySheet_Previews: PreviewProvider {
    @State static var emptyActivity = Activity()
    @State static var showCreateActivityButton = true
    static var previews: some View {
        JoinedActivitySheet(activity: $emptyActivity, showCreateActivityButton: $showCreateActivityButton)
    }
}
