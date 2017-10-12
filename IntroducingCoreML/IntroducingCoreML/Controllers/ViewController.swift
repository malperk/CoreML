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
    let flowerModel = Oxford102()
    let imagePicker = UIImagePickerController()

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var predictionLabel: UILabel!
    
    
    lazy var classificationRequest: VNCoreMLRequest = {
        // Load the ML model through its generated class and create a Vision request for it.
        do {
            let model = try VNCoreMLModel(for: Oxford102().model)
            return VNCoreMLRequest(model: model, completionHandler: self.handleClassification)
        } catch {
            fatalError("can't load Vision ML model: \(error)")
        }
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    @IBAction func takePictureClicked(_: Any) {
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

    public func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        imagePicker.dismiss(animated: true)
        guard let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
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
