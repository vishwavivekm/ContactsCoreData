//
//  ContactTableViewCell.swift
//  ContactsCoreData
//
//  Created by brn.developers on 5/1/19.
//  Copyright © 2019 Vivek. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactMobile: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
