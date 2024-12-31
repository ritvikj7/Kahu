//
//  ContentView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            // Main content (tabs)
            TabView {
                // Feed Tab
                FeedView()
                    .tabItem {
                        Label("Feed", systemImage: "house.fill") // SF Symbol for home
                    }

                // Search Tab
                SearchView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                // Camera Tab
                CameraView()
                    .tabItem {
                        Label("Camera", systemImage: "camera.fill")
                    }

                // Profile Tab
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "pawprint.fill")
                    }
            }
            
            // Divider above the TabView
            Divider()
                .background(Color.gray) // Customize color
                .frame(height: 1) // Adjust thickness of the line
                .padding(.bottom, 90) // Adjust to position the line just above the tabs
        }
        .edgesIgnoringSafeArea(.bottom) // Ensure the TabView extends to the screen's bottom
    }
}

struct FeedView: View {
    var body: some View {
        VStack {
            Text("Camera access is required to proceed. Please enable camera permissions in your device's settings.")
                .font(.title2)
                .fontWeight(.medium)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            
            Button(action: {
                // Open the app's settings page
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            }) {
                Text("Request Permission")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity) // Make button full width
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 10) // Adds shadow for depth
            }
            .padding(.horizontal, 30) // Horizontal padding for button
            .padding(.top, 20) // Add some space from the text
        }
        .padding()
        .background(Color.gray.opacity(0.1)) // Light background for the container
        .cornerRadius(20) // Rounded corners for the container
        .shadow(radius: 10) // Shadow around the whole container for depth
        .padding(.horizontal, 20) // Add padding to the sides
    }
}

struct SearchView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Search for content")
                    .font(.largeTitle)
                    .padding()

                // Example Search content
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Search Result 1")
                        Text("Search Result 2")
                        Text("Search Result 3")
                    }
                    .padding()
                }
            }
            .navigationTitle("Search")
        }
    }
}




#Preview {
    ContentView()
}
