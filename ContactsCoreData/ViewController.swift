//
//  ViewController.swift
//  ContactsCoreData
//
//  Created by brn.developers on 4/29/19.
//  Copyright © 2019 Vivek. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    
    @IBOutlet weak var contactsTable: UITableView!
    
    var contactsArray:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactsTable.tableFooterView = UIView.init(frame:.zero)
        
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return contactsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contactsTable.dequeueReusableCell(withIdentifier: "contactsCell", for: indexPath)
        return cell
    }
    
    
}

