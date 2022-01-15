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
    
    @State var modifySheet = false
    @State var previewSheet = false
    @State var addSheet = false
    @State var currActivity = Activity()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activityData.activities) { activity in
                    if activity.creator.id != userData.currentUser.id {
                        NavigationLink(activity.description) {
                            PreviewActivityView(activity: binding(for: activity))
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
            .foregroundColor(.berkeleyBlue)
            .listStyle(.plain)
            .toolbar {
                ToolbarItem {
                    Button(action: { addSheet.toggle() }) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .navigationTitle("Activities")
            //            .sheet(isPresented: $modifySheet, content: { ModifyActivityView(activity: $currActivity, isPresenting: $modifySheet) })
            //            .sheet(isPresented: $previewSheet, content: { PreviewActivityView(activity: $currActivity, isPresenting: $previewSheet) })
            .sheet(isPresented: $addSheet, content: { AddActivitySheet(isPresenting: $addSheet) })
        }
    }
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

