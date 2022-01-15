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
    @State var addSheetPresenting = false
    
    @State private var oldSelectedItem = 1
    
    var body: some View {
        TabView(selection: $selectedItem) {
            GlobalActivityView()
                .tabItem {
                    Image(systemName: "house")
                }.tag(1)
            Text("")
                .tabItem() {
                    Image(systemName: "plus")
                }.tag(2)
            UserProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                }.tag(3)
        }
        .onChange(of: selectedItem) {
            if selectedItem == 2 {
                self.addSheetPresenting = true
            } else {
                self.oldSelectedItem = $0
            }
        }
        .fullScreenCover(isPresented: $addSheetPresenting , onDismiss: { self.selectedItem = self.oldSelectedItem }, content: { AddActivitySheet(isPresenting: $addSheetPresenting) })
        .interactiveDismissDisabled()
        
        .environmentObject(userData)
        .environmentObject(activityData)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
