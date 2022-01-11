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
    @State var addSheetPresented = false
    
    var body: some View {
        TabView {
            GlobalActivityView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            UserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .environmentObject(userData)
        .environmentObject(activityData)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
