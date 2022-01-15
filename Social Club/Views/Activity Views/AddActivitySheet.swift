//
//  AddActivitySheet.swift
//  Social Club
//
//  Created by Alex M on 1/9/22.
//

import SwiftUI

struct AddActivitySheet: View {
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject private var activityData: ActivityData
    
    @State var newActivity = Activity()
    @Binding var isPresenting: Bool
    @State var alertCPresenting = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Posting as: \(userData.currentUser.name)")
                        .font(.subheadline)
                        .padding()
                    Spacer()
                }
                Form {
                    Section("Describe Activity") {
                        TextEditor(text: $newActivity.description)
                    }
                    Section("Activity location") {
                        TextEditor(text: $newActivity.location)
                    }
                    Section("Time of activity") {
                        DatePicker("Date/Time", selection: $newActivity.date)
                    }
                }
                Button("Create Activity") {
                    alertCPresenting = true
                }
                Spacer()
                    .navigationTitle("Add Activity")
                    .toolbar {
                        ToolbarItem {
                            HStack {
                                Button(action: {
                                    alertCPresenting = true
                                }) {
                                    Image(systemName: "checkmark.circle.fill")
                                }
                                
                                Button(action: {
                                    isPresenting = false
                                }) {
                                    Image(systemName: "xmark.circle")
                                }
                            }
                        }
                    }
            }
        }
        .alert("Activity Created", isPresented: $alertCPresenting, actions: { Button("Cool", role: .cancel, action: {
            newActivity.creator = userData.currentUser
            activityData.addActivity(activity: newActivity)
            isPresenting = false }) })
    }
}

struct AddActivitySheet_Previews: PreviewProvider {
    @State static var isPresenting = true
    @State static var isCPresenting = false
    @State static var isJPresenting = false
    
    static var previews: some View {
        AddActivitySheet(newActivity: Activity(), isPresenting: $isPresenting)
            .environmentObject(UserData())
            .environmentObject(ActivityData())
    }
}
