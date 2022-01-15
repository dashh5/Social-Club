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
    
    @State var alertMPresenting = false
    
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
                Section("Time of activity") {
                    DatePicker("Select Time", selection: $activity.date)
                }
            }
            
            Button("Save") {
                alertMPresenting = true
            }
            
            Spacer()
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            alertMPresenting = true
                        }) {
                            Image(systemName: "checkmark.circle.fill")
                        }
                        
                    }
                }
                .alert("Activity Modified", isPresented: $alertMPresenting, actions: { Button("Cool", role: .cancel, action: {
                    self.presentationMode.wrappedValue.dismiss()
                    activity.update(to: activity)
                }) })
        }
        
    }
}

struct ModifyActivityView_Previews: PreviewProvider {
    @State static var activity = Activity()
    @State static var isPresenting = true
    @State static var alertMPresenting = false
    
    static var previews: some View {
        ModifyActivityView(activity: $activity)
            .environmentObject(UserData())
            .environmentObject(ActivityData())
    }
}
