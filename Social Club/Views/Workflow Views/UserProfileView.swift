//
//  UserProfileView.swift
//  Social Club
//
//  Created by Alex M on 1/9/22.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var activityData: ActivityData
    
    @State var showInfoSheet = false
    
    @State var showCreateActivityButton = false
    
    var body: some View {
        NavigationView {
            VStack {
                infoRow
                Spacer()
                Form {
                    Section("Year") {
                        Picker("Select Year (optional)", selection: $userData.currentUser.year) {
                            ForEach(User.Year.allCases) { year in
                                Text(year.rawValue)
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                    let bioBinding = Binding(get: { currentUser.bio ?? "" }, set: { userData.currentUser.setBio(to: $0) } )
                    Section("Bio") {
                        TextField("What do you like to do for fun?", text: bioBinding)
                            .lineLimit(15)
                    }
                    .onTapGesture {
                        hideKeyboard()
                    }
                    .submitLabel(.done)
                    Section("History") {
                        if currentUser.activities.count == 0 {
                            Text("Join some activities!")
                        } else {
                            List {
                                ForEach(currentUser.activities.sorted(by: { $0.date < $1.date })) { activity in
                                    if !(currentUser.inThisActivity(activity: activity)) {
                                        NavigationLink("\(activity.description) (\(activity.timeTillActivityString))", destination: { PreviewActivityView(activity: binding(for: activity), showCreateActivityButton: $showCreateActivityButton) })
                                    } else {
                                        NavigationLink("\(activity.description) (\(activity.timeTillActivityString))", destination: { PreviewActivityView(activity: binding(for: activity), showCreateActivityButton: $showCreateActivityButton) })
                                            .foregroundColor(.purple)
                                    }
                                }
                            }
                        }
                        
                    }
                    .foregroundColor(.gray)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("@\(userData.currentUser.name)")
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .padding(.top)
                    }
                }
                .sheet(isPresented: $showInfoSheet) {
                    
                }
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
        userData.currentUser
    }
    
    var userActivities: [Activity] {
        currentUser.activities
    }
    
    var infoRow: some View {
        HStack {
            Button(action: {}) {
                currentUser.profilePic
                    .font(.system(size: 80))
            }
            .padding(.leading)
            VStack {
                Text(String(currentUser.activities.count))
                Text("Joined")
            }
            .padding()
            VStack {
                Text(String(currentUser.activitiesPosted()))
                Text("Posted")
            }
            .padding()
            VStack {
                Text("0")
                Text("TBD")
            }
            .padding()
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    @State static var userData = UserData()
    @State static var activityData = ActivityData()
    
    static var previews: some View {
        UserProfileView()
            .environmentObject(userData)
            .environmentObject(activityData)
    }
}

