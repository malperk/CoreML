//
//  ViewController.swift
//  IntroducingCoreML
//
//  Created by Alper KARATAŞ on 11/10/2017.
//  Copyright © 2017 Coda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let flowerModel = Oxford102()
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }

    @IBAction func takePictureClicked(_: Any) {
    }
    @IBAction func selectPictureClicked(_: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelegate Methods

    public func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        guard let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        guard let pixelBuffer = pickedImage.resize(newSize: CGSize(width: 227, height: 227)).pixelBuffer()  else {
            return
        }
        let fowerPrediction = try? flowerModel.prediction(data: pixelBuffer)
        print(fowerPrediction?.classLabel)
        
    }

    public func imagePickerControllerDidCancel(_: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
