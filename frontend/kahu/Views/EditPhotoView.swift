//
//  EditPhotoView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-29.
//

import SwiftUI

struct EditPhotoView: View {
    @StateObject private var viewModel = PostViewModel()
    @State private var userCaption: String = ""
    @State private var userLocation: String = ""
    @State private var userDate: Date = Date()
    @State private var isLoading = false
    @ObservedObject var cameraViewModel: CameraViewModel
    var image: UIImage?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 17) {
                    // Image Section with Edit Button
                    
                    if let uiImage = image{
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 350)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .padding(.horizontal)
                    }
                    
                    // Caption Field
                    HStack(spacing: 15) {
                        Image(systemName: "text.bubble.fill")
                            .foregroundColor(.gray)
                        TextField("Add a caption...", text: $userCaption)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.1))
                    )
                    .padding(.horizontal)
                    
                    // Location Field
                    HStack(spacing: 15) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.gray)
                        TextField("Add location...", text: $userLocation)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.1))
                    )
                    .padding(.horizontal)
                    
                    // Date Picker
                    HStack(spacing: 15) {
                        Image(systemName: "calendar.circle.fill")
                            .foregroundColor(.gray)
                        DatePicker(
                            "Select date",
                            selection: $userDate,
                            displayedComponents: .date
                        )
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.1))
                    )
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.vertical)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("New Post")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isLoading {
                    ProgressView()
                } else {
                    Button {
                        Task {
                            await handlePost()
                            cameraViewModel.resetCameraSession()
                        }
                    } label: {
                        Image(systemName: "arrow.right.circle.fill")
                            .font(.title3)
                    }
                }
            }
        }
    }
    
    private func handlePost() async {
        guard let image = image else {
            print("Image is required.")
            return
        }
        isLoading = true
        await viewModel.postImage(caption: userCaption, location: userLocation, date: userDate, image: image)
        isLoading = false
    }
}
