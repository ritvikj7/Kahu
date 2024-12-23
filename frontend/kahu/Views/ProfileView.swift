//
//  ProfileView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-21.
//

import SwiftUI

struct ProfileView: View {
    // Observing the ProfileViewModel
    // @StateObject is used to create and manage the lifecycle of an ObservableObject within a view. It ensures that the object persists across view updates and is not recreated unnecessarily.
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        VStack {
            if let petProfile = viewModel.petProfile {
                // Display the pet profile details
                VStack(alignment: .leading, spacing: 10) {
                    Text("Name: \(petProfile.name)")
                    Text("Breed: \(petProfile.breed)")
                    Text("Age: \(petProfile.age)")
                    Text("Birthday: \(petProfile.birthday)")
                    Text("Weight: \(petProfile.weight) kg")
                    Text("Gender: \(petProfile.gender)")
                }
                .padding()
            } else {
                // Show a loading or placeholder message
                Text("Loading profile...")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            // .onAppear is a SwiftUI view modifier that attaches an action to be performed when the view is added to the view hierarchy
            // Fetch the profile when the view appears
            Task {
                // Task is a unit of asynchronous work
                await viewModel.getProfile()
            }
        }
        .navigationTitle("Pet Profile")
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
