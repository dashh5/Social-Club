//
//  AddActivitySheet.swift
//  Social Club
//
//  Created by Alex M on 1/9/22.
//

import SwiftUI

struct AddActivitySheet: View {
    @EnvironmentObject private var userData: UserData
    @EnvironmentObject private var activityData: ActivityData
    
    @State var newActivity = Activity()
    @Binding var isPresenting: Bool
    @State private var alertCPresenting = false
    @State private var alertIPresenting = false
    
    @FocusState private var currentFocused: Field?
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Posting as: \(userData.currentUser.name)")
                        .font(.subheadline)
                        .padding()
                    Spacer()
                }
                Form {
                    Section("Describe Activity") {
                        TextField("", text: $newActivity.description)
                            .focused($currentFocused, equals: .describing)
                    }
                    .onTapGesture(perform: {
                        hideKeyboard()
                    })
                    Section("Activity location") {
                        TextField("", text: $newActivity.location)
                            .focused($currentFocused, equals: .location)
                    }
                    .onTapGesture(perform: {
                        hideKeyboard()
                    })
                    Section("How many slots availible?") {
                        Stepper("\(newActivity.peopleNeeded) \(newActivity.peopleNeeded == 1 ? "person" : "people")", value: $newActivity.peopleNeeded, in: ClosedRange(uncheckedBounds: (0, 20)))
                    }
                    Section("Time of activity") {
                        DatePicker("Select", selection: $newActivity.date)
                    }
                }
                .submitLabel(.next)
                .onSubmit {
                    switch currentFocused {
                    case .describing:
                        currentFocused = .location
                    default:
                        break
                    }
                }
                Button(action: {
                    if userData.currentUser.inActivity {
                        alertIPresenting = true
                    } else {
                        alertCPresenting = true
                    }
                }) {
                    Design.blueLongButtonLabel(text: "Post Activity")
                }
                .disabled(notCreatable)
                .padding(.horizontal)
                .padding(.bottom)
                .navigationTitle("Post Activity")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button(action: {
                            isPresenting = false
                        }) {
                            Image(systemName: "xmark")
                        }
                    }
                }
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .alert("Activity Created", isPresented: $alertCPresenting, actions: { Button("Cool", role: .cancel, action: {
            newActivity.creator = userData.currentUser
            activityData.addActivity(activity: newActivity)
            userData.currentUser.joinActivity(activity: newActivity)
            isPresenting = false }
        ) })
        .alert("Error: You are currently in an activity!", isPresented: $alertIPresenting, actions: { Button("Ok", role: .cancel, action: {}
        ) })
    }
    
    var notCreatable: Bool {
        return !(newActivity.description.count > 4 && newActivity.peopleNeeded > 1 && newActivity.location.count > 4)
    }
    
    enum Field {
        case describing
        case location
        case nothing
    }
    
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}

struct AddActivitySheet_Previews: PreviewProvider {
    @State static var isPresenting = true
    @State static var isCPresenting = false
    @State static var isJPresenting = false
    
    static var previews: some View {
        AddActivitySheet(newActivity: Activity(), isPresenting: $isPresenting)
            .environmentObject(UserData())
            .environmentObject(ActivityData())
    }
}
