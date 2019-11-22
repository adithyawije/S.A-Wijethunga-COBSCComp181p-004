//
//  AddPostViewController.swift
//  S.A-Wijethunga-COBSCComp181p-004
//
//  Created by Isuru Devinda on 11/22/2562 BE.
//  Copyright © 2562 BE Digital-02. All rights reserved.
//

import UIKit
import Firebase

class AddPostViewController: UIViewController {
    @IBOutlet weak var imagePost: UIImageView!
    
    @IBOutlet weak var titlePost: UITextField!
    
    @IBOutlet weak var userName: UITextField!

    @IBOutlet weak var postDescription: UITextField!
    var imagePicker:UIImagePickerController!
    var ref = DatabaseReference.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        self.ref = Database.database().reference()
        imagePost.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pickImager(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
//    @IBAction func savePost(_ sender: Any) {
//        if (titlePost.text == "") {
//            alert(message: "title is required")
//            return
//        }
//
//        if (postDescription.text == ""){
//            alert(message: "Description Is Required")
//            return
//        }
//        if (imagePost.image == nil){
//            alert(message: "Image Is Required")
//            return
//        }
//        self.saveFIRData()
//        navigationController?.popViewController(animated: true)
//    }
    @IBAction func addPost(_ sender: Any) {
                if (titlePost.text == "") {
                    alert(message: "title is required")
                    return
                }
        
                if (postDescription.text == ""){
                    alert(message: "Description Is Required")
                    return
                }
                if (imagePost.image == nil){
                    alert(message: "Image Is Required")
                    return
                }
                self.saveFIRData()
                navigationController?.popViewController(animated: true)
    }
    
    func saveFIRData(){
        self.uploadMedia(image: imagePost.image!){ url in
            self.saveImage(profileImageURL: url!){ success in
                if (success != nil){
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
    }
    
    
    func uploadMedia(image :UIImage, completion: @escaping ((_ url: URL?) -> ())) {
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("Articles").child(imageName)
        let imgData = self.imagePost.image?.pngData()
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
            if error == nil{
                storageRef.downloadURL(completion: { (url, error) in
                    completion(url)
                })
            }else{
                print("error in save image")
                completion(nil)
            }
        }
    }
    
    func saveImage(profileImageURL: URL , completion: @escaping ((_ url: URL?) -> ())){
        
        let dict = [
            "authur": userName.text!,
            "title": titlePost.text!,
            "desc": postDescription.text!,
            "imageUrl": profileImageURL.absoluteString] as [String : Any]
        self.ref.child("articles").childByAutoId().setValue(dict)
        self.alert(message: "Article Added Successfully")
    }
    
}



extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.imagePost.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

