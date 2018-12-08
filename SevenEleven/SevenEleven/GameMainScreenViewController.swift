//
//  GameOpenScreenViewController.swift
//  SevenEleven
//
//  Created by hunkar lule on 2018-12-04.
//  Copyright © 2018 hunkar lule. All rights reserved.
//

import UIKit

class GameMainScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if UIApplication.isFirstLaunch() {
            UserDefaults.standard.set(1000, forKey: "Balance")
        }
        
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath = paths.first {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("yourAvatar.jpg")
            if let image = UIImage(contentsOfFile: imageURL.path) {
                imageView.image = image
            }
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(avatarImageTapped(gesture:)))
        
        // add it to the image view;
        imageView.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        imageView.isUserInteractionEnabled = true
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        if  UserDefaults.standard.integer(forKey:"Balance") <= 0 {
            let ac = UIAlertController(title: "Chips!", message: "You have no chips. Please buy chip to continue to play", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "GameSegue",  UserDefaults.standard.integer(forKey:"Balance") <= 0 {
            return false
        } else {
            return true
        }
    }
    @objc func avatarImageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if (gesture.view as? UIImageView) != nil {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                showPhotoMenu()
            }
            else {
                choosePhotoFromLibrary()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chipsAmountLabel.text = "\(UserDefaults.standard.integer(forKey: "Balance"))$"
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBOutlet weak var imageView: UIImageView!
    private var image: UIImage?
    
    @IBOutlet weak var chipsAmountLabel: UILabel!
    
    func showPhotoMenu() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let photoAction = UIAlertAction(title: "Take Photo", style: .default, handler: { _ in self.takePhotoWithCamera() })
        alert.addAction(photoAction)
        
        let libraryAction = UIAlertAction(title: "Choose From Library", style: .default, handler: { _ in self.choosePhotoFromLibrary()})
        alert.addAction(libraryAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension GameMainScreenViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    // MARK:- Image Picker Delegates
    
    // Delegate will be notified when user is done
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        if let theImage = image {
            imageView.image = theImage
            
            // Save avatar photo
            saveImageInDocsDir(theImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    // Dismiss it when cancel happens
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    private func saveImageInDocsDir(_ imagetoSave: UIImage) {
        let image: UIImage? = imagetoSave
        if !(image == nil) {
            let fileManager = FileManager.default
            let documentsURL =  fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let imagesPath = documentsURL.appendingPathComponent("Images")
            do
            {
                try FileManager.default.createDirectory(atPath: imagesPath.path, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error as NSError
            {
                NSLog("Unable to create directory \(error.debugDescription)")
            }
            
            let fileURL = documentsURL.appendingPathComponent("yourAvatar.jpg")
            let data = image?.jpegData(compressionQuality: 1.0)
            
            do {
                try data?.write(to: fileURL, options: .atomic)
            } catch {
                print("error:", error)
            }
        }
    }
}

