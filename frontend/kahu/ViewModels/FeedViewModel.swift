//
//  FeedViewModel.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-31.
//

import Foundation

/*
When we mark a property with @Published, it means that any change to that property will trigger an update in the UI.
Because of "ObservableObject" any SwiftUI view that uses this object will be notified when changes occur to its @Published properties.
The guard statement is similar to the if statement with one major difference. The if statement runs when a certain condition is met. However, the guard statement runs when a certain condition is not met.
Marking the method or class with @MainActor ensure that all UI-related code is executed on the main thread, and Swift will automatically handle thread safety for you.
 */

class FeedViewModel: ObservableObject {
    @Published var petProfile: PetProfile?

    
    
    
}
