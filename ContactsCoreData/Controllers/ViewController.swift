//
//  ViewController.swift
//  ContactsCoreData
//
//  Created by brn.developers on 4/29/19.
//  Copyright © 2019 Vivek. All rights reserved.
//

import UIKit
import CoreData

var data:String = ""

class ViewController: UIViewController {
    
    
    @IBOutlet weak var contactsTable: UITableView!
    
    @IBOutlet weak var contactNameLbl: UILabel!
    @IBOutlet weak var contactMobileLbl: UILabel!
    
    var contactName:[String] = []
    var contactLastName:[String] = []
    var contactMobile:[Int64] = []
    var contactImage:[UIImage] = []
    
    var managedObjectContext:NSManagedObjectContext!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactName.sort()
        
        contactsTable.tableFooterView = UIView.init(frame:.zero)
       
        managedObjectContext = appDelegate.persistentContainer.viewContext
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchContact()
        contactsTable.reloadData()
        
    }
    
    func fetchContact(){
        
        contactName = []
        contactLastName = []
        contactMobile = []
        contactImage = []
        
        let contactFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
        do{
            let contactList = try managedObjectContext.fetch(contactFetch)
            for i in 0..<contactList.count{
                let contactManagedObject:NSManagedObject = contactList[i] as! NSManagedObject
                contactName.append(contactManagedObject.value(forKey: "firstName") as! String)
                 contactLastName.append(contactManagedObject.value(forKey: "lastName") as! String)
                contactMobile.append(contactManagedObject.value(forKey: "mobile") as! Int64)
                
                if let imageData = contactManagedObject.value(forKey: "contactImage")
                {
                    contactImage.append(UIImage(data: imageData as! Data)!)
                }
                
            }
            
        }catch{
            print(error)
        }
        
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTable.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
        cell.contactMobile.text = "\(contactMobile[indexPath.row])"
        cell.contactName.text = contactName[indexPath.row]
        cell.contactImage.image = contactImage[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: UITableViewRowAction.Style.default, title: "Delete") { (action, indexPath) in
            
            let contactFetch:NSFetchRequest = Contacts.fetchRequest()
            contactFetch.predicate = NSPredicate(format: "firstName = %@", self.contactName[indexPath.row])
            do{
                let contactFetchObj = try self.managedObjectContext.fetch(contactFetch)
                for items in contactFetchObj{
                    self.managedObjectContext.delete(items)
                }
                try self.managedObjectContext.save()
                self.fetchContact()
                self.contactsTable.reloadData()
            }catch{
                print(error)
            }
        }
        
        return [delete]
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var updateContact = self.storyboard?.instantiateViewController(withIdentifier: "UpdateViewController") as! UpdateViewController
        
        present(updateContact, animated: true) {
            
            updateContact.firstNameUpdateTF.text = self.contactName[indexPath.row]
            updateContact.lastNameUpdateTF.text = self.contactLastName[indexPath.row]
            updateContact.mobileUpdateTF.text = "\(self.contactMobile[indexPath.row])"
            updateContact.updateImage.image = self.contactImage[indexPath.row]
            
            data = self.contactName[indexPath.row]
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
}

