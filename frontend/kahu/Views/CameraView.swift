//
//  CameraView.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-27.
//


import SwiftUI
import AVFoundation

struct CameraView: View {
    @StateObject private var cameraViewModel = CameraViewModel() // The CameraViewModel instance
    
    var body: some View {
        if !cameraViewModel.hasCameraPermission {
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
        else {
            NavigationView{
                VStack {
                    if cameraViewModel.isCameraActive {
                        // Live camera feed
                        VStack{
                            CameraPreviewView(session: cameraViewModel.getCaptureSession())
                                .edgesIgnoringSafeArea(.all)
                            
                            Button(action: {
                                cameraViewModel.capturePhoto()
                            }) {
                               Image(systemName: "circle.fill")
                                   .font(.largeTitle) // Set the size of the icon
                                   .foregroundColor(.black) // Set the icon color to blue
                                   .padding() // Padding around the icon
                                   .background(Color.white) // White background
                                   .clipShape(Circle()) // Make the button round
                                   .shadow(radius: 10) // Add shadow for depth
                           }
                           .padding(.bottom, 30)
                        }
                    } else {
                        ZStack(alignment: .bottom) {
                            // Show the captured image if the camera is inactive
                            if let capturedImage = cameraViewModel.capturedImage {
                                Image(uiImage: capturedImage)
                                    .resizable()
                                    .scaledToFit()
                                    .edgesIgnoringSafeArea(.all)
                                
                                // Bottom buttons (Retry and Proceed)
                                HStack {
                                    // Retry Button
                                    Button(action: {
                                        cameraViewModel.startCameraSession() // Retry capturing the photo
                                    }) {
                                        Image(systemName: "xmark") // "Replay" or "retry" icon
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.black)
                                            .clipShape(Circle())
                                            .shadow(radius: 10)
                                    }
                                    .padding(.bottom, 30)
                                    
                                    Spacer()
                                    
                                    // Proceed Button
                                    NavigationLink(destination: EditPhotoView(image: capturedImage)) {
                                        Image(systemName: "arrow.right") // "Proceed" or "confirm" icon
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(Color.black)
                                            .clipShape(Circle())
                                            .shadow(radius: 10)
                                    }
                                    .padding(.bottom, 30)
                                }
                                .padding()
                            }
                        }
                    }
                }
            }
        }
    }
}

// CameraPreviewView is used to display the live camera feed
// Think of CameraPreviewView as an adapter that takes the camera session (which is UIKit-based) and presents it in a way that SwiftUI can understand and display
// The key thing to understand is that makeUIViewController is called once when the view is created, while updateUIViewController is called whenever the view needs to be updated with new data.
// Credit to ChatGPT for this adapter code. 
struct CameraPreviewView: UIViewControllerRepresentable {
    var session: AVCaptureSession?

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let previewLayer = AVCaptureVideoPreviewLayer(session: session!)
        previewLayer.frame = viewController.view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewController.view.layer.addSublayer(previewLayer)
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update the preview layer when the session changes
        if let session = session {
            if let previewLayer = uiViewController.view.layer.sublayers?.first(where: { $0 is AVCaptureVideoPreviewLayer }) as? AVCaptureVideoPreviewLayer {
                previewLayer.session = session
            }
        }
    }
}
