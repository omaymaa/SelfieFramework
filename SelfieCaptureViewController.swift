//
//  SelfieCaptureViewController.swift
//  SelfieCaptureFramework
//
//  Created by Omayma Marouf on 12/10/2024.
//

import UIKit
import AVFoundation

class SelfieCaptureViewController: UIViewController, AVCapturePhotoCaptureDelegate {
    var captureSession: AVCaptureSession!
    var photoOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    // Additional properties to handle captured image
    var capturedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
    }
    
    func setupCamera() {
        captureSession = AVCaptureSession()
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        photoOutput = AVCapturePhotoOutput()
        if (captureSession.canAddOutput(photoOutput)) {
            captureSession.addOutput(photoOutput)
        } else {
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    let captureButton: UIButton = {
        let button = UIButton()
        button.setTitle("Capture", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        captureButton.frame = CGRect(x: (view.bounds.width - 100) / 2, y: view.bounds.height - 70, width: 100, height: 50)
        view.addSubview(captureButton)
    }
    
    @objc func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        capturedImage = UIImage(data: imageData)
        // Navigate to the image review screen
        navigateToImageReview()
    }
    
    func navigateToImageReview() {
        let reviewVC = ImageReviewViewController()
        reviewVC.image = capturedImage
        reviewVC.delegate = self
        navigationController?.pushViewController(reviewVC, animated: true)
    }
}

extension SelfieCaptureViewController: SelfieCaptureDelegate {
    func didCaptureImage(image: UIImage?) {
        print("Captured image approved.")
    }
}
