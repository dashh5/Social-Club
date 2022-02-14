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
    @Binding var showCreateActivityButton: Bool
    
    @State var alertJPresenting = false
    @State var alertAPresenting = false
    @State var alertSPresenting = false
    @State var alertLPresenting = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    activity.creator.profilePic
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .font(.system(size: 50))
                        .mask(Circle())
                        .padding(.leading)
                        .padding(.trailing, 5)
                    Text("\(activity.creator.name)")
                        .multilineTextAlignment(.leading)
                        .padding(.vertical)
                        .font(.title2)
                    Text("• \(activity.creator.year.rawValue)")
                        .foregroundColor(.gray)
                        .font(.title2)
                    Spacer()
                }
                Text(activity.creator.bio ?? "This is an example bio of a person that will take up multiple lines. ")
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .foregroundColor(.gray)
                activity.timeTillActivityView
                    .padding(.horizontal)
                    .font(.system(size: 19))
            }
            List {
                Section("Description") {
                    Text(activity.description)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.vertical)
                }
                
                let inDorm = activity.dorm != nil
                Section("Location \(inDorm ? "From Dorm: \(activity.dorm?.rawValue ?? "")" : "")") {
                    Text(activity.location)
                }
                //                Section("Date & Time") {
                //                    Text(activity.date, format: .dateTime)
                //                }
                Section("People needed") {
                    Text(String(activity.peopleNeeded))
                }
            }
            
            if !userData.currentUser.inThisActivity(activity: activity)  {
                Button(action: { join() }) {
                    Design.blueLongButtonLabel(text: "Sign Up")
                }
                .padding(.horizontal)
                .padding(.bottom)
            } else {
                Button(action: { showLeaveAlert() }) {
                    Design.redLongButtonLabel(text: "Leave Activity")
                        .padding(.horizontal)
                        .padding(.bottom)
                }
            }
            
        }

        .navigationTitle("Preview Activity")
        .navigationBarTitleDisplayMode(.large)
        .alert("Activity Joined", isPresented: $alertJPresenting, actions: { Button("Cool", role: .cancel, action: {
            activityJoinedActions()
        }) })
        .alert("Activity Left", isPresented: $alertLPresenting, actions: { Button("Cool", role: .cancel, action: {
            activityLeftActions()
        }) })
        .alert("Error: Activity has no more slots availible!", isPresented: $alertSPresenting, actions: { Button("Ok", role: .cancel, action: {
        }) })
        
        .onAppear(perform: { showCreateActivityButton = false })
    }
    
    var currentUser: User {
        userData.currentUser
    }
    
    func join() {
        if activity.peopleNeeded == 0 {
            alertSPresenting = true
        } else {
            alertJPresenting = true
        }
    }
    
    func activityLeftActions() {
        activity.peopleNeeded += 1
        userData.currentUser.leaveActivity(activity: activity)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func showLeaveAlert() {
        alertLPresenting = true
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
    @State static var showCreateActivityButton = true
    
    static var previews: some View {
        PreviewActivityView(activity: $emptyActivity, showCreateActivityButton: $showCreateActivityButton)
            .environmentObject(UserData())
    }
}
