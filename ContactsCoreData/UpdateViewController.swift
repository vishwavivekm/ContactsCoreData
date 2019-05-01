//
//  UpdateViewController.swift
//  ContactsCoreData
//
//  Created by brn.developers on 4/29/19.
//  Copyright © 2019 Vivek. All rights reserved.
//

import UIKit

class UpdateViewController: UIViewController {

    @IBOutlet weak var updateImage: UIImageView!
    @IBOutlet weak var firstNameUpdateTF: UITextField!
    @IBOutlet weak var lastNameUpdateTF: UITextField!
    @IBOutlet weak var mobileUpdateTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateImage.layer.cornerRadius = updateImage.frame.size.width/2
    }
    

    @IBAction func updateContact(_ sender: Any) {
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
