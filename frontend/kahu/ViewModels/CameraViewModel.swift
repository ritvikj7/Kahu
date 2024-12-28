//
//  CameraViewModel.swift
//  kahu
//
//  Created by Ritvik Joshi on 2024-12-27.
//


import AVFoundation
import SwiftUI

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var capturedImage: UIImage? // Holds the captured photo
    @Published var isCameraActive: Bool = true // Controls camera session
    @Published var hasCameraPermission: Bool = false // Tracks permission status

    private var captureSession: AVCaptureSession? // Manages the flow of data from the camera to your app.
    private var photoOutput = AVCapturePhotoOutput() // Handles the process of capturing photos.

    override init() {
        super.init()
        checkCameraPermission()
    }
    
    func getCaptureSession() -> AVCaptureSession? {
        return captureSession
    }

    // Request Camera Permissions
    func checkCameraPermission() {
        // Check the current permession state
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            hasCameraPermission = true
            // Ideally I would like to extract this function call out of the method.
            setupCamera()
        case .notDetermined:
            // requestAccess is an async method.
            // { [weak self] granted in ... } is the closure (similar to a callback in typescript) which will
            // be called after the async function executes.
            // [weak self] ensures that the CameraViewModel instance can be freed from memory when it's no longer needed, even if the closure is still waiting for the user’s input.
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    self?.hasCameraPermission = granted
                    if granted {
                        self?.setupCamera()
                    }
                }
            }
        // Default case will be when authorization status ends up being .restricted, or .denied
        default:
            hasCameraPermission = false
        }
    }

    // Responsible for configuring and starting the camera session for capturing photos. It initializes the camera, sets up input and output for the camera session, and begins running the session.
    private func setupCamera() {
        captureSession = AVCaptureSession()
        // We are using shadowing i.e creating a new constant with the same name but with the unwrapped value
        // The guard let statement unwraps the optional captureSession (which is a property of the class) and assigns it to a new constant captureSession that is only available within the scope of the guard block.
        guard let captureSession = captureSession else { return }
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        do {
            let input = try AVCaptureDeviceInput(device: device)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }

            if captureSession.canAddOutput(photoOutput) {
                captureSession.addOutput(photoOutput)
            }

            // starts the camera session, which begins the continuous flow of data from the camera.
            captureSession.startRunning()
        } catch {
            print("Error setting up camera: \(error)")
        }
    }

    // Capture a single photo when called.
    func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
}

extension CameraViewModel {
    // A delegate method which is called when a photo has been captured and processed. It provides you with the captured photo and any potential errors
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data) else {
            print("Error capturing photo: \(String(describing: error))")
            return
        }

        DispatchQueue.main.async {
            self.capturedImage = image
            self.isCameraActive = false // Stop showing the camera preview
        }
    }
}
