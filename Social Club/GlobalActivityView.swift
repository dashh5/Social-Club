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
    @State var showCreateActivityButton = true
    @Binding var activities: [Activity]
    
    let timer = Timer.publish(every: 60.0, on: .main, in: .common).autoconnect()
    
    @State var searchText: String = ""
    
    @State var currActivity = Activity()
    @State var addSheetPresenting = false
    @State var showJoinedActivitySheet = false
    @State var alertJoinedPresenting = false
    @State var showAckSheet = false
    @State var showReportSheet = false
    
    @State var boolMe = false
    
    var body: some View {
        ZStack {
            feedView
            if showCreateActivityButton {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        newActivityButton
                            .padding(.bottom, 70)
                            .padding(.trailing)
                    }
                }
            }
        }
        .onReceive(timer, perform: { _ in
            
        })
        .sheet(isPresented: $showAckSheet, content: { AcknowledgementsSheet() })
        .sheet(isPresented: $showReportSheet, content: { ReportSheet() })
        .fullScreenCover(isPresented: $addSheetPresenting, content: { AddActivitySheet(isPresenting: $addSheetPresenting, showCreateActivityButton: $showCreateActivityButton) })
        .interactiveDismissDisabled()
    }
    
    var currentUser: User {
        userData.currentUser
    }
}

extension GlobalActivityView {
    var newActivityButton: some View {
        Button(action: { addSheetPresenting = true }) {
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
                    ForEach(activityData.getActivities()) { activity in
                        if activity.creator.id != userData.currentUser.id {
                            NavigationLink(destination: {
                                PreviewActivityView(activity: binding(for: activity), showCreateActivityButton: $showCreateActivityButton)
                                
                            }, label: {
                                ActivityView(activity: activity, showReportSheet: $showReportSheet)
                            })
                        } else {
                            NavigationLink(destination: {
                                ModifyActivityView(activity: binding(for: activity), showCreateActivityButton: $showCreateActivityButton)
                                    .navigationTitle("Modify Activity")
                            }, label: {
                                ActivityView(activity: activity, showReportSheet: $showReportSheet)
                            })
                                .foregroundColor(Color.purple)
                        }
                    }
                }
                .refreshable {
                    activityData.activities.sort(by: { $0.date < $1.date })
                    activities = activityData.activities
                }
                .onAppear(perform: { showCreateActivityButton = true })
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                
                .listStyle(PlainListStyle())
                .navigationTitle("FOMO")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { showReportSheet = true }) {
                            Image(systemName: "person.crop.circle.badge.exclamationmark")
                                .foregroundColor(.blue)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { showAckSheet = true }) {
                            Image(systemName: "message.fill")
                                .foregroundColor(.blue)
                        }
                    }
                }
                .sheet(isPresented: $showJoinedActivitySheet, onDismiss: { showCreateActivityButton = true }, content: {
                    NavigationView {
                        PreviewActivityView(activity: binding(for: getNextActivity()), showCreateActivityButton: $showCreateActivityButton)
                    }
                     })
                
                if userData.currentUser.inActivity && showCreateActivityButton {
                    Button(action: { showJoinedActivitySheet = true }) {
                        Design.newLongButtonLabel(text: "Next Activity")
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
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
    
    func getMostRecentActivity() -> Binding<Activity> {
        return binding(for: userData.currentUser.activities[userData.currentUser.activities.endIndex - 1])
    }
    
    func getMostRecentActivityNonBinding() -> Activity {
        return  userData.currentUser.activities[userData.currentUser.activities.endIndex - 1]
    }
    
    func getNextActivity() -> Activity {
        return currentUser.activitiesIn[0]
    }
}

struct ActivityView: View {
    @State var activity: Activity
    @Binding var showReportSheet: Bool
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack {
                    Text(activity.creator.name)
                        .bold()
                        .lineLimit(1)
                    if activity.dorm != nil {
                        Text("• \(activity.dorm?.rawValue ?? "")")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top, 5)
                Text(activity.description)
                    .fixedSize(horizontal: false, vertical: true)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                ActivityBottomRowView(activity: $activity)
                    .foregroundColor(.gray)
                    .padding([.bottom, .top], 6)
                    
            }
        }
    }
}

struct ActivityBottomRowView: View {
    @Binding var activity: Activity
    @EnvironmentObject var userData: UserData
    
    @State var yeet = [User()]
    
    let timer = Timer.publish(every: 60.0, on: .main, in: .common).autoconnect()
    
    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "person.2")
            }
            let atendees = activity.atendees?.count ?? 0
            Text(activity.peopleNeeded - atendees > 0 ? "\(atendees)/\(activity.peopleNeeded)" : "")
            Spacer()
            let diff = activity.getDateDiff()
            let neg = diff?.minute ?? 0 < 0 || diff?.hour ?? 0 < 0
            activity.timeTillActivityView
                .lineLimit(1)
                .truncationMode(.middle)
                .foregroundColor(neg ? .red : .green)
        }
        .onReceive(timer, perform: { _ in
            yeet.append(contentsOf: [User()])
        })
    }
}

extension Color {
    static var berkeleyBlue: Color = Color(red: 00/255, green: 50/255, blue: 98/255)
    static var berkeleyGold: Color = Color(red: 253/255, green: 181/255, blue: 21/255)
}

struct GlobalActivityView_Previews: PreviewProvider {
    @State static var activities = [Activity()]
    
    static var previews: some View {
        GlobalActivityView(activities: $activities)
            .environmentObject(UserData())
            .environmentObject(ActivityData())
    }
}

