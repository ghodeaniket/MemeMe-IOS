//
//  ViewController.swift
//  MemeMe
//
//  Created by Aniket Ghode on 27/03/17.
//  Copyright © 2017 Aniket Ghode. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
 
    //MARK: Buttons Tag
    enum TabBarButtons: Int {
        case camera = 0, album
    }
    
    //MARK:- Properties
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    var imagePicker: UIImagePickerController!
    
    // TextField TextAttributes
    let memeTextAttributes: [String: Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -2.5
    ]
    
    //MARK:- View Controller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields(topTextField)
        configureTextFields(bottomTextField)
        shareButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // check if camera is available and enable/disable the camera button
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        self.subscribeToKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeToKeyboardNotification()
    }
    
    //MARK:- Helper Methods
    func configureTextFields(_ textField: UITextField) {
        textField.isHidden = true
        textField.borderStyle = .none
        textField.backgroundColor = UIColor.clear
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.delegate = self
    }
    
    //MARK:- TextField Delegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    //MARK:- IBActions
    @IBAction func pickAnImage(_ sender: UIBarButtonItem) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        switch (TabBarButtons(rawValue: sender.tag)!) {
        case .camera:
            imagePicker.sourceType = .camera
        case .album:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Reset the imageView and Strings from TextField.
    @IBAction func cancelMeme(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Create Memed Image and provide it to the ActivityView Controller.
    @IBAction func shareMeme(_ sender: Any) {
        // Create the memedImage
        let memedImage = generateMemedImage()
        // Provide the item to share i.e. MemedImage
        let shareViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        shareViewController.completionWithItemsHandler = {(activity, completed, items, error) in
            if completed {
                self.saveMeme()
            }
        }
        present(shareViewController, animated: true, completion: nil)
    }
    
    //MARK:- UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Pick image and display it in imageView
        print(info)
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            imagePickerView.image = image
        }
        topTextField.isHidden = false
        bottomTextField.isHidden = false
        shareButton.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // dismiss the image picker dialog
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- Keyboard Adjustment Methods
    
    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(){
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func saveMeme() {
        // Create the meme
        let meme = Meme(topCaption: topTextField.text!, bottomCaption: bottomTextField.text!, originalImage: imagePickerView.image, memedImage: generateMemedImage())
        
        //Add it to memes array in AppDelegate
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.memes.append(meme)
        
        // Dismiss the view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        //Hide navigation bar and toolbar
        toolbar.isHidden = true
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        //Show navigation bar and toolbar
        toolbar.isHidden = false
        return memedImage
    }

}

