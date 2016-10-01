//
//  View1.swift
//  Ma Made It-Swift
//
//  Created by Joaquim Patrick Ramos Grilo on 2015-12-04.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

var signUpstate = true

class View1: UIViewController {
    
    @IBAction func toLogInMenu(_ sender: AnyObject) {

        if signUpstate == true {
            
            
        signUpstate = false
            self.performSegue(withIdentifier: "signuplogin", sender: self)
            
        }
        
        
    }

    @IBAction func toSignUpMenu(_ sender: AnyObject) {
        
        if signUpstate == true {
            
            
            self.performSegue(withIdentifier: "signuplogin", sender: self)
            
        } else {
            
            signUpstate = true
            self.performSegue(withIdentifier: "signuplogin", sender: self)
            
        }
       

        
    
    }
    
 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current()?.username != nil
        {
            self.performSegue(withIdentifier: "skipLogin", sender: self)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

