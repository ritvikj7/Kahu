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
            .navigationTitle("Feed")
        }
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
