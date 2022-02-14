//
//  AcknowledgementsSheet.swift
//  Berkeley Social Club
//
//  Created by Alex M on 1/26/22.
//

import SwiftUI

struct AcknowledgementsSheet: View {
    @State var suggestion: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Berkeley Social Club is the brainchild of a Cal undergraduate that found it difficult to make lasting friendships first year. I hope you like it, and if you have any suggestions, please post them here 😄❤️.")
                    .font(.headline)
                    .padding()
                Spacer()
                Form {
                    Section("Enter Comments/Feedback") {
                        TextEditor(text: $suggestion)
                            .frame(height: 100)
                    }
                    HStack {
                        Spacer()
                        Button("Submit Feedback") {
                            // submit feedback somehow..
                            
                            presentationMode.wrappedValue.dismiss()
                        }
                        Spacer()
                    }
                }
                .padding()
                .navigationTitle("Acknowledgements")
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Image(systemName: "xmark")
                    }
                }
            }
            
        }
        
    }
}

struct AcknowledgementsSheet_Previews: PreviewProvider {
    
    static var previews: some View {
        AcknowledgementsSheet()
    }
}
