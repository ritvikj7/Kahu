//
//  EditProfileView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-25.
//

import SwiftUI

struct EditProfileView: View {
    var petProfile: PetProfile
    
    var body: some View {
        NavigationView {
        VStack {
            Text("Welcome to the Feed")
                .font(.largeTitle)
                .padding()

            // Example Feed content
            ScrollView {
                VStack(spacing: 20) {
                    Text("Post 1")
                    Text("Post 2")
                    Text("Post 3")
                }
                .padding()
            }
        }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Feed")
        }
    }
}

