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
                ScheduleView()
                    .tabItem {
                        Label("Schedule", systemImage: "calendar")
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
                .frame(height: -5) // Adjust thickness of the line
                .padding(.bottom, 87.5) // Adjust to position the line just above the tabs
        }
        .edgesIgnoringSafeArea(.bottom) // Ensure the TabView extends to the screen's bottom
    }
}



#Preview {
    ContentView()
}
