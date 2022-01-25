//
//  ContentView.swift
//  Social Club
//
//  Created by Alex M on 1/9/22.
//

import SwiftUI

struct GlobalActivityView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var activityData: ActivityData
    @Environment(\.presentationMode) var presentationMode
    
    @State var currActivity = Activity()
    @State var showJoinedActivitySheet = false
    @State var alertJoinedPresenting = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    List {
                        ForEach(activityData.activities) { activity in
                            if activity.creator.id != userData.currentUser.id {
                                NavigationLink(activity.description) {
                                    PreviewActivityView(activity: binding(for: activity))
                                        .navigationTitle("Preview Activity")
                                }
                            } else {
                                NavigationLink(activity.description) {
                                    ModifyActivityView(activity: binding(for: activity), activityPeopleNeeded: activity.peopleNeeded)
                                        .navigationTitle("Modify Activity")
                                }
                                .foregroundColor(Color.purple)
                                
                            }
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Activities")
                    .sheet(isPresented: $showJoinedActivitySheet, content: { JoinedActivitySheet(activity: getMostRecentActivity()) })
                    if userData.currentUser.inActivity {
                        Button(action: { showJoinedActivitySheet = true }) {
                            Design.blueLongButtonLabel(text: "Joined Activity")
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    newActivityButton
                        .padding(.bottom, 65)
                        .padding(.trailing)
                }
            }
        }
        
        
    }
    
    var currentUser: User {
        userData.currentUser
    }
}

extension GlobalActivityView {
    
    private var activities: [Activity] {
        return activityData.activities
    }
    
    func binding(for activity: Activity) -> Binding<Activity> {
        guard let index = activityData.index(of: activity) else {
            fatalError("Activity not found")
        }
        return $activityData.activities[index]
    }
    
    func getMostRecentActivity() -> Binding<Activity> {
        return binding(for: userData.currentUser.activities[userData.currentUser.activities.endIndex - 1])
    }
    
    func getMostRecentActivityNonBinding() -> Activity {
        return  userData.currentUser.activities[userData.currentUser.activities.endIndex - 1]
    }
    
    var newActivityButton: some View {
        Button(action: { showJoinedActivitySheet = true }) {
            Image(systemName: "plus")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
        }
        .background(.blue)
        .mask(Circle())
        .shadow(radius: 5)
    }
    
    var feedView: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(activityData.activities) { activity in
                        if activity.creator.id != userData.currentUser.id {
                            NavigationLink(activity.description) {
                                PreviewActivityView(activity: binding(for: activity))
                                    .navigationTitle("Preview Activity")
                            }
                        } else {
                            NavigationLink(activity.description) {
                                ModifyActivityView(activity: binding(for: activity), activityPeopleNeeded: activity.peopleNeeded)
                                    .navigationTitle("Modify Activity")
                            }
                            .foregroundColor(Color.purple)
                            
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Activities")
                .sheet(isPresented: $showJoinedActivitySheet, content: { JoinedActivitySheet(activity: getMostRecentActivity()) })
                if userData.currentUser.inActivity {
                    Button(action: { showJoinedActivitySheet = true }) {
                        Design.blueLongButtonLabel(text: "Joined Activity")
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
    }
}

struct ActivityRow: View {
    @Binding var activity: Activity
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var activityData: ActivityData
    
    var body: some View {
        HStack {
            Image(systemName: "arrow.up")
                .padding()
            let karma = userData.currentUser.karma
            Text(karma > 5 ? "\(karma)" : "")
            Spacer()
            let peopleSignedUp = activity.atendees?.count
            let peopleNeeded = activity.peopleNeeded
            Text("\(String(peopleSignedUp ?? 0))/\(String(peopleNeeded)) ppl")
            Spacer()
            activity.timeTillActivityView
        }
    }
    
}

extension Color {
    static var berkeleyBlue: Color = Color(red: 00/255, green: 50/255, blue: 98/255)
    static var berkeleyGold: Color = Color(red: 253/255, green: 181/255, blue: 21/255)
}

struct GlobalActivityView_Previews: PreviewProvider {
    
    static var previews: some View {
        GlobalActivityView()
            .environmentObject(UserData())
            .environmentObject(ActivityData())
    }
}

