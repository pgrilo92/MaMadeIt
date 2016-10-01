//
//  Settings.swift
//  Ma Made It-Swift
//
//  Created by Joaquim Patrick Ramos Grilo on 2015-12-12.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class MoreDetailedFoodView: UIViewController {
    
    @IBOutlet var textLabel: UILabel!
    
    var varView = Int()

    override func viewDidLoad() {
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        if(varView == 0){
            
         textLabel.text = "string"
            
            
        } else {
            textLabel.text = "others"
        }
        
    }
    
    
    
}
