//
//  MainTabView.swift
//  Social Club
//
//  Created by Alex M on 1/9/22.
//

import SwiftUI

struct MainTabView: View {
    @StateObject private var userData = UserData()
    @StateObject private var activityData = ActivityData()
    @State private var selectedItem = 1
    
    
    @State private var oldSelectedItem = 1
    
    @State var showCreateActivityButton = false
    
    var body: some View {
        TabView(selection: $selectedItem) {
            GlobalActivityView(activities: $activityData.activities)
                .tabItem {
                    Image(systemName: "house")
                }.tag(1)
            UserProfileView()
                .tabItem {
                    userData.currentUser.profilePic
                }.tag(3)
        }
        .tabViewStyle(.automatic)
//        .onChange(of: selectedItem) {
//            if selectedItem == 2 {
//                if userData.currentUser.inActivity {
//                    selectedItem = oldSelectedItem
//                    alertJoinedPresenting = true
//                } else {
//                    self.oldSelectedItem = $0
//                }
//            }
//        }
        .environmentObject(userData)
        .environmentObject(activityData)
    }
    
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
