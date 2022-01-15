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
    @Binding var joinedActivity: Bool
    
    @State var alertJPresenting = false
    @State var alertAPresenting = false
    
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Posted by: \(activity.creator.name)")
                        .multilineTextAlignment(.leading)
                        .padding()
                    Spacer()
                }
                let diff = activity.getDateDiff()
                if (Int(diff) ?? 1) < 1 {
                    Text("Just now")
                        .padding(.leading)
                } else {
                    Text("\(diff) minute\(Int(diff) ?? 2 == 1 ? "" : "s") ago")
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
            }
            Button("Join Activity") {
                joinable()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .toolbar {
            ToolbarItem {
                HStack {
                    Button(action: {
                        joinable()
                    }) {
                        Text("Join")
                    }
                }
                
            }
        }
        .alert("Activity Joined", isPresented: $alertJPresenting, actions: { Button("Cool", role: .cancel, action: {
            activityJoinedActions()
        }) })
        .alert("Error: You're already in an activity!", isPresented: $alertAPresenting, actions: { Button("Ok", role: .cancel, action: {
            
        }) })
    }
    
    func joinable() {
        if joinedActivity {
            alertAPresenting = true
        } else {
            alertJPresenting = true
        }
    }
    
    func activityJoinedActions() {
        joinedActivity = true
        self.presentationMode.wrappedValue.dismiss()
        userData.currentUser.joinActivity(activity: activity)
    }
}

struct PreviewActivityView_Previews: PreviewProvider {
    @State static var emptyActivity = Activity()
    @State static var isPresenting = true
    @State static var showActivityButton = false
    
    static var previews: some View {
        PreviewActivityView(activity: $emptyActivity, joinedActivity: $showActivityButton)
    }
}
