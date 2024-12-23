//
//  ProfileViewModel.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-21.
//

import Foundation

/*
When we mark a property with @Published, it means that any change to that property will trigger an update in the UI.
Because of "ObservableObject" any SwiftUI view that uses this object will be notified when changes occur to its @Published properties.
The guard statement is similar to the if statement with one major difference. The if statement runs when a certain condition is met. However, the guard statement runs when a certain condition is not met.
Marking the method or class with @MainActor ensure that all UI-related code is executed on the main thread, and Swift will automatically handle thread safety for you.
 */

class ProfileViewModel: ObservableObject {
    @Published var petProfile: PetProfile?

    // Fetch the profile from the backend
    func getProfile() async {
        guard let url = URL(string: "http://localhost:8080/profile") else {
            print("Invalid URL")
            return
        }

        do {
            // Perform the network request on a background thread
            let (data, _) = try await URLSession.shared.data(from: url)

            // Decode the JSON on a background thread
            let decoder = JSONDecoder()
            let profile = try decoder.decode(PetProfile.self, from: data)

            // Update the UI on the main thread
            await MainActor.run {
                self.petProfile = profile
            }
        } catch {
            print("Error fetching or decoding profile: \(error)")
        }
    }
}
