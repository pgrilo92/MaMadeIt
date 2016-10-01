//
//  MainTableCell.swift
//  Ma Made It-Swift
//
//  Created by Joaquim Patrick Ramos Grilo on 2015-12-17.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class MainTableCell: UITableViewCell {
    
    @IBOutlet var foodImage: UIImageView!
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var foodTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
