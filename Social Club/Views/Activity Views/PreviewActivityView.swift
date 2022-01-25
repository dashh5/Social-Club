//
//  PreviewActivityView.swift
//  Social Club
//
//  Created by Alex M on 1/11/22.
//

import SwiftUI

struct PreviewActivityView: View {
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject private var activityData: ActivityData
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var activity: Activity
    
    @State var alertJPresenting = false
    @State var alertAPresenting = false
    @State var alertSPresenting = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Posted by: \(activity.creator.name)")
                        .multilineTextAlignment(.leading)
                        .padding()
                    Spacer()
                }
                activity.timeTillActivityView
                    .padding(.leading)
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
            }
            Button(action: { join() }) {
                Design.blueLongButtonLabel(text: "Sign Up")
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .alert("Activity Joined", isPresented: $alertJPresenting, actions: { Button("Cool", role: .cancel, action: {
            activityJoinedActions()
        }) })
        .alert("Error: You're already in an activity!", isPresented: $alertAPresenting, actions: { Button("Ok", role: .cancel, action: {
            
        }) })
        .alert("Error: Activity has no more slots availible!", isPresented: $alertSPresenting, actions: { Button("Ok", role: .cancel, action: {
        }) })
    }
    
    func join() {
        let inActivity: Bool = userData.currentUser.inActivity
        if inActivity {
            alertAPresenting = true
        } else if !inActivity && activity.peopleNeeded > 0 {
            alertJPresenting = true
        } else if activity.peopleNeeded == 0 {
            alertSPresenting = true
        }
    }
    
    func activityJoinedActions() {
        activity.peopleNeeded -= 1
        userData.currentUser.joinActivity(activity: activity)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct PreviewActivityView_Previews: PreviewProvider {
    @State static var emptyActivity = Activity()
    @State static var isPresenting = true
    
    static var previews: some View {
        PreviewActivityView(activity: $emptyActivity)
    }
}
