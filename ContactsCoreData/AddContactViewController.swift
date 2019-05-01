//
//  AddContactViewController.swift
//  ContactsCoreData
//
//  Created by brn.developers on 4/29/19.
//  Copyright © 2019 Vivek. All rights reserved.
//

import UIKit
import CoreData


class AddContactViewController: UIViewController, UIImagePickerControllerDelegate {
    
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
        
        
        
    }
    @IBAction func saveContact(_ sender: Any) {
        
        let managedObject = NSManagedObject(entity: contactsEntity, insertInto: managedObjectContext)
        managedObject.setValue("\(firstNameTF.text)", forKey: "firstName" )
        managedObject.setValue("\(lastNameTF.text)", forKey: "lastName" )
        managedObject.setValue("\(mobileTF.text)", forKey: "mobile" )
        
        do{
            try managedObjectContext.save()
        }catch{
            error
        }
        
    }
    
    @IBAction func cancelSaveAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
}
