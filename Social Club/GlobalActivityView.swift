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
    
    @State var modifySheet = false
    @State var previewSheet = false
    @State var addSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activityData.activities) { activity in
                    Button(activity.description) {
                        if userData.currentUser.id == activity.creator.id {
                            modifySheet = true
                        } else {
                            previewSheet = true
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: { addSheet.toggle() }) {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            .navigationTitle("Activities")
            .sheet(isPresented: $modifySheet, content: { ModifyActivitySheet() })
            .sheet(isPresented: $previewSheet, content: { PreviewActivitySheet() })
            .sheet(isPresented: $addSheet, content: { AddActivitySheet() })
        }
    }
}

struct GlobalActivityView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalActivityView()
            .environmentObject(ActivityData())
    }
}

