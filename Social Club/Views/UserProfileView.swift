//
//  UserProfileView.swift
//  Social Club
//
//  Created by Alex M on 1/9/22.
//

import SwiftUI

struct UserProfileView: View {
    @EnvironmentObject private var userData: UserData
    var body: some View {
        Text("Profile view!")
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
