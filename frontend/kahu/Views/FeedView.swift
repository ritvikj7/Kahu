//
//  FeedView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-31.
//

import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel = FeedViewModel()
    @State var numberOfPosts = 0
    @State var currentState: String = "Regular"
    @State private var regularImages: [UIImage] = []
    @State private var aiImages: [UIImage] = []
    
    var images: [UIImage] {
        currentState == "Regular" ? regularImages : aiImages
    }
    
    // Calculate grid layout
    let columns = Array(repeating: GridItem(.flexible(), spacing: 2), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView {
                feedContent
            }
            .onAppear {
                Task {
                    await viewModel.getProfile()
                    viewModel.getImage()
                    numberOfPosts = viewModel.image.count
                    regularImages = viewModel.image
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Feed")
        }
    }
    
    private var feedContent: some View {
        VStack(spacing: 0) {
            statisticsView
            toggleButtonsView
            imageGridView
        }
    }
    
    private var statisticsView: some View {
        HStack(spacing: 55) {
            CountLabelView(count: String(numberOfPosts), label: "Posts")
            CountLabelView(count: "15", label: "Comments")
            CountLabelView(count: "40", label: "Likes")
        }
        .padding()
    }
    
    private var toggleButtonsView: some View {
        HStack {
            Spacer()
            Button(action: { currentState = "Regular" }) {
                Image(systemName: "squareshape.split.3x3")
                    .font(.title)
                    .foregroundColor(currentState == "Regular" ? Color.primary : Color.secondary)
            }
            Spacer()
            Button(action: { currentState = "AI" }) {
                Image(systemName: "wand.and.stars")
                    .font(.title)
                    .foregroundColor(currentState == "AI" ? Color.primary : Color.secondary)
            }
            Spacer()
        }
        .padding()
    }
    
    private var imageGridView: some View {
        Group {
            if numberOfPosts == 0 {
                emptyStateView
            } else {
                imagesGrid
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack {
            Spacer()
                    .frame(height: 150)
            Image(systemName: "camera.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 100)
                .foregroundColor(.gray)
            
            Text("No post yet")
                .font(.title)
                .foregroundColor(.gray)
                .padding(.top, 10)
        }
    }
    
    private var imagesGrid: some View {
        LazyVGrid(columns: columns, spacing: 2) {
            ForEach(images.indices, id: \.self) { index in
                imageCell(for: index)
            }
        }
        .padding(.horizontal, 0)
    }
    
    private func imageCell(for index: Int) -> some View {
        NavigationLink(destination: PostView(image: images[index])){
            Image(uiImage: images[index])
                .resizable()
                .scaledToFill()
                .frame(width: (UIScreen.main.bounds.width - 2) / 3,
                       height: (UIScreen.main.bounds.width - 2) / 3)
                .clipped()
        }
    }
}


#Preview {
    FeedView()
}
