//
//  UpdateViewController.swift
//  ContactsCoreData
//
//  Created by brn.developers on 4/29/19.
//  Copyright © 2019 Vivek. All rights reserved.
//

import UIKit
import CoreData


class UpdateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var updateImage: UIImageView!
    @IBOutlet weak var firstNameUpdateTF: UITextField!
    @IBOutlet weak var lastNameUpdateTF: UITextField!
    @IBOutlet weak var mobileUpdateTF: UITextField!
    
    var managedObjectContext:NSManagedObjectContext!
    var appDelegate:AppDelegate!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImage.layer.cornerRadius = updateImage.frame.size.width/2
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
         managedObjectContext = appDelegate.persistentContainer.viewContext
        
        tapGesture()
        
    }
    func tapGesture(){
        var imageTap = UITapGestureRecognizer.init(target: self, action: #selector(onTapImage(sender:)))
        updateImage.addGestureRecognizer(imageTap)
        updateImage.isUserInteractionEnabled = true
    }
    
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
        updateImage.image = picked as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    
    

    @IBAction func updateContact(_ sender: Any) {
        
        let fetchUpdate:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Contacts")
        fetchUpdate.predicate = NSPredicate(format: "firstName = %@", data)
        do{
            var updateContactObject = try managedObjectContext.fetch(fetchUpdate)
            for i in 0..<updateContactObject.count{
                let updateContact = updateContactObject[i] as! NSManagedObject
                updateContact.setValue(firstNameUpdateTF.text, forKey: "firstName")
                updateContact.setValue(lastNameUpdateTF.text, forKey: "lastName")
                updateContact.setValue(Int64(mobileUpdateTF.text!), forKey: "mobile")
                if let updateImageData = updateImage.image?.jpegData(compressionQuality: 1.0){
                    updateContact.setValue(updateImageData, forKey: "contactImage")
                }
            }
            try managedObjectContext.save()
            
        }catch{
            print(error)
        }

        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelUpdateAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
