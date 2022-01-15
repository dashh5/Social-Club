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
                alertJPresenting = true
            }
            .foregroundColor(.white)
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .foregroundColor(.berkeleyBlue)
        .toolbar {
            ToolbarItem {
                HStack {
                    Button(action: {
                        alertJPresenting = true
                    }) {
                        Text("Join")
                    }
                }
                
            }
        }
        
        .alert("Activity Joined", isPresented: $alertJPresenting, actions: { Button("Cool", role: .cancel, action: {
            self.presentationMode.wrappedValue.dismiss()
            userData.currentUser.joinActivity(activity: activity)
        }) })
    }
}

struct PreviewActivityView_Previews: PreviewProvider {
    @State static var emptyActivity = Activity()
    @State static var isPresenting = true
    
    static var previews: some View {
        PreviewActivityView(activity: $emptyActivity)
    }
}
