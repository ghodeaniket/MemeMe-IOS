//
//  ViewController.swift
//  MemeMe
//
//  Created by Aniket Ghode on 27/03/17.
//  Copyright © 2017 Aniket Ghode. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    //MARK: Buttons Tag
    enum TabBarButtons: Int {
        case Camera = 0, Album
    }

    
    //MARK:- Properties
    
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    var imagePicker: UIImagePickerController!
    
    // TextField TextAttributes
    let memeTextAttributes: [String: Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: 2.5
    ]
    
    //MARK:- View Controller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.defaultTextAttributes = memeTextAttributes
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // check if camera is available and enable/disable the camera button
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    //MARK:- IBActions
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        switch (TabBarButtons(rawValue: sender.tag)!) {
        case .Camera:
            imagePicker.sourceType = .camera
        case .Album:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    //MARK:- UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Pick image and display it in imageView
        print(info)
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imagePickerView.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // dismiss the image picker dialog
        imagePicker.dismiss(animated: true, completion: nil)
    }

}

