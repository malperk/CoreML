//
//  ViewController.swift
//  IntroducingCoreML
//
//  Created by Alper KARATAŞ on 11/10/2017.
//  Copyright © 2017 Coda. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let imagePicker = UIImagePickerController()

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var predictionLabel: UILabel!
    
    
    lazy var classificationRequest: VNClassifyImageRequest = {
        // Vision's built-in classifier, so no model file has to be bundled.
        return VNClassifyImageRequest(completionHandler: self.handleClassification)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    @IBAction func takePictureClicked(_: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            predictionLabel.text = "Camera is not available on this device"
            return
        }
        imagePicker.sourceType = .camera
        imagePicker.cameraCaptureMode = .photo
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func selectPictureClicked(_: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelegate Methods

    public func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        imagePicker.dismiss(animated: true)
        guard let pickedImage = info[.originalImage] as? UIImage else {
            return
        }
        guard let ciImage = CIImage(image: pickedImage)else {
            return
        }

        imageView.image = pickedImage
        let handler = VNImageRequestHandler(ciImage: ciImage)
        
        do {
            try handler.perform([classificationRequest])
        } catch {
            print(error)
        }

        
    }
    
    func handleClassification(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNClassificationObservation]
            else { fatalError("unexpected result type from VNCoreMLRequest") }
        guard let best = observations.first
            else { fatalError("can't get best result") }
        
        DispatchQueue.main.async {
            self.predictionLabel.text = "Classification: \"\(best.identifier)\" Confidence: \(best.confidence)"
        }
    }

    public func imagePickerControllerDidCancel(_: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
