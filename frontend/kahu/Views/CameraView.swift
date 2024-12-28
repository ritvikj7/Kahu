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
        VStack {
            if cameraViewModel.isCameraActive {
                // Live camera feed
                CameraPreviewView(session: cameraViewModel.getCaptureSession())
                    .edgesIgnoringSafeArea(.all)
            } else {
                // Show the captured image if the camera is inactive
                if let capturedImage = cameraViewModel.capturedImage {
                    Image(uiImage: capturedImage)
                        .resizable()
                        .scaledToFit()
                        .edgesIgnoringSafeArea(.all)
                }
            }
            
            // Button to capture a photo
            Button(action: {
                cameraViewModel.capturePhoto()
            }) {
                Text("Capture Photo")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
//        .onAppear {
//            // Check and request camera permissions when the view appears
//            cameraViewModel.checkCameraPermission()
//        }
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
