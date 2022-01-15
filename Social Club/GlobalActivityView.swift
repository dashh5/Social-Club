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
    @State var showActivityButton = false
    @State var showJoinedActivitySheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(activityData.activities) { activity in
                        if activity.creator.id != userData.currentUser.id {
                            NavigationLink(activity.description) {
                                PreviewActivityView(activity: binding(for: activity), joinedActivity: $showActivityButton)
                                    .navigationTitle("Preview Activity")
                            }
                        } else {
                            NavigationLink(activity.description) {
                                ModifyActivityView(activity: binding(for: activity))
                                    .navigationTitle("Modify Activity")
                            }
                            .foregroundColor(Color.purple)
                            
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Activities")
                .sheet(isPresented: $showJoinedActivitySheet, content: { JoinedActivitySheet() })
                if showActivityButton {
                    Button(action: { showJoinedActivitySheet = true }) {
                        longButtonLabel
                    }
                    .padding(.bottom)
                }
            }
        }
    }
}

var longButtonLabel: some View {
    HStack {
        Spacer()
        Text("Current Activity")
            .foregroundColor(Color.berkeleyGold)
            .font(.body)
            .bold()
            .padding()
        Spacer()
    }
    .background(Color.berkeleyBlue).cornerRadius(2.5)
}

extension GlobalActivityView {
    
    private var activities: [Activity] {
        return activityData.activities
        
    }
    
    func binding(for activity: Activity) -> Binding<Activity> {
        guard let index = activityData.index(of: activity) else {
            fatalError("Recipe not found")
        }
        return $activityData.activities[index]
    }
}

struct ActivityRow: View {
    @Binding var activity: Activity
    
    var body: some View {
        NavigationView {
            
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

