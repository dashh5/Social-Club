//
//  ModifyActivitySheet.swift
//  Social Club
//
//  Created by Alex M on 1/9/22.
//

import SwiftUI

struct ModifyActivityView: View {
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject private var activityData: ActivityData
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var activity: Activity
    @State var activityPeopleNeeded: Int
    
    @State var alertMPresenting = false
    @State var alertDPresenting = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Posted by: \(userData.currentUser.name) (you)")
                    .font(.subheadline)
                    .padding()
                    .foregroundColor(Color.purple)
                Spacer()
            }
            Form {
                Section("Describe Activity") {
                    TextEditor(text: $activity.description)
                        .foregroundColor(Color.purple)
                }
                Section("Activity location") {
                    TextEditor(text: $activity.location)
                        .foregroundColor(Color.purple)
                }
                Section("How many slots availible?") {
                    Stepper("\(activity.peopleNeeded) \(activity.peopleNeeded == 1 ? "person" : "people")", value: $activity.peopleNeeded, in: ClosedRange(uncheckedBounds: (0, 20)))
                }
                Section("Time of activity") {
                    DatePicker("Select", selection: $activity.date)
                }
            }
            Button(action: {
                if canJoinBack {
                    userData.currentUser.joinActivity(activity: activity)
                } else {
                    alertDPresenting = true
                }
            }) {
                if canJoinBack {
                    Design.blueLongButtonLabel(text: "Join Back")
                } else {
                    Design.redLongButtonLabel(text: "Delete Activity")
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .alert("Delete activity?", isPresented: $alertDPresenting, actions: { Button("Yes", role: .destructive, action: {
            activityData.removeActivity(activity: activity)
            userData.currentUser.inActivity = false
            self.presentationMode.wrappedValue.dismiss() })})
    }
    
    // when a person leaves their own activity that they created, this bools tells the compiler whether or not they are eligible to join back
    var canJoinBack: Bool {
        return activity.creator.id == userData.currentUser.id && !userData.currentUser.inActivity
    }
}

struct ModifyActivityView_Previews: PreviewProvider {
    @State static var activity = Activity()
    @State static var isPresenting = true
    @State static var alertMPresenting = false
    
    static var previews: some View {
        ModifyActivityView(activity: $activity, activityPeopleNeeded: activity.peopleNeeded)
            .environmentObject(UserData())
            .environmentObject(ActivityData())
    }
}
