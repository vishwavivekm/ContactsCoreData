//
//  UpdateViewController.swift
//  ContactsCoreData
//
//  Created by brn.developers on 4/29/19.
//  Copyright © 2019 Vivek. All rights reserved.
//

import UIKit
import CoreData


class UpdateViewController: UIViewController {

    @IBOutlet weak var updateImage: UIImageView!
    @IBOutlet weak var firstNameUpdateTF: UITextField!
    @IBOutlet weak var lastNameUpdateTF: UITextField!
    @IBOutlet weak var mobileUpdateTF: UITextField!
    
    var managedObjectContext:NSManagedObjectContext!
    var appDelegate:UIApplicationDelegate!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImage.layer.cornerRadius = updateImage.frame.size.width/2
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
//        managedObjectContext = appDelegate.persistentContainer.viewContext
         managedObjectContext = ((UIApplication.shared.delegate) as! AppDelegate).persistentContainer.viewContext
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
