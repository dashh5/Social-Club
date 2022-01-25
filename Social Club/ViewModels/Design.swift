//
//  Design.swift
//  Berkeley Social Club
//
//  Created by Alex M on 1/19/22.
//

import Foundation
import SwiftUI

struct Design {
    static func blueLongButtonLabel(text: String) -> some View {
        HStack {
            Spacer()
            Text(text)
                .foregroundColor(Color.white)
                .font(.body)
                .bold()
                .padding()
            Spacer()
        }
        .background(Color.blue).cornerRadius(2.5)
    }
    
    static func redLongButtonLabel(text: String) -> some View {
        HStack {
            Spacer()
            Text(text)
                .foregroundColor(Color.white)
                .font(.body)
                .bold()
                .padding()
            Spacer()
        }
        .background(Color.red).cornerRadius(2.5)
    }
}
