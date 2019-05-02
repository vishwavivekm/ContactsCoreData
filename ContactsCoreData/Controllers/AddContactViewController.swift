//
//  AddContactViewController.swift
//  ContactsCoreData
//
//  Created by brn.developers on 4/29/19.
//  Copyright © 2019 Vivek. All rights reserved.
//

import UIKit
import CoreData


class AddContactViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var appDelegate:AppDelegate!
    var managedObjectContext:NSManagedObjectContext!
    var contactsEntity:NSEntityDescription!
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var mobileTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactImage.layer.cornerRadius = contactImage.frame.size.width/2
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
        tapGesture()
    }
    // Tap Gesture for Image picking
    
    func tapGesture(){
        var imageTap = UITapGestureRecognizer.init(target: self, action: #selector(onTapImage(sender:)))
        contactImage.addGestureRecognizer(imageTap)
        contactImage.isUserInteractionEnabled = true
    }
    // Getting Image from Image picker
    func imagePicker(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
        
    }
    
    @objc func onTapImage(sender:UITapGestureRecognizer)
    {
        if sender.view as? UIImageView != nil
        {
            imagePicker()
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let picked = info[UIImagePickerController.InfoKey.editedImage]
        contactImage.image = picked as? UIImage
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveContact(_ sender: Any) {
        
        contactsEntity = NSEntityDescription.entity(forEntityName: "Contacts", in: managedObjectContext)
        let managedObject = NSManagedObject(entity: contactsEntity, insertInto: managedObjectContext)
        managedObject.setValue(firstNameTF.text, forKey: "firstName")
        managedObject.setValue(lastNameTF.text, forKey: "lastName")
        managedObject.setValue(Int64(mobileTF.text!), forKey: "mobile")
        if let imageData = contactImage.image?.jpegData(compressionQuality: 1.0){
            managedObject.setValue(imageData, forKey: "contactImage")
        }
        do{
            try managedObjectContext.save()
        }catch{
            print(error)
        }
        
        dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func cancelSaveAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
