//
//  SignUp.swift
//  Ma Made It-Swift
//
//  Created by Joaquim Patrick Ramos Grilo on 2015-12-05.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse


class SignUp: UIViewController, UITextFieldDelegate

{
    
    func displayAlert(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    

    
    
    

    @IBOutlet var facebookLogIn: UITextField!
   
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var nextSignUp: UIButton!
    
    
        
    @IBAction func nextSignUpButton(_ sender: AnyObject) {
    
        if email.text == "" || password.text == "" {
            
           
            displayAlert("Missing Field(s)", message: "Email and Password Are Required")
            
            
           
        } else {
           
            
           
            
            if signUpstate == true {
               
                
                
                let user = PFUser()
                user.username = email.text
                user.password = password.text
                user.email = email.text

                
            
           
        
            // other fields can be set just like with PFObject
            user["isCook"] = `switch`.isOn
                
            
            user.signUpInBackground {
                (succeeded: Bool, error: NSError?) -> Void in
                if let error = error {
                    if let errorString = error.userInfo["error"] as? String {
                    
                    
               self.displayAlert("Sign Up Failed", message: errorString)
                    }
                    
                    
                } else {
                    
                    
                    if self.`switch`.isOn == true {
                        
                        self.performSegue(withIdentifier: "toCook", sender: self)
                        
                    } else {
                        self.performSegue(withIdentifier: "toFoodie", sender: self)
                    }
                    
                }
                
                }
                    
                } else {
                
                PFUser.logInWithUsername(inBackground: email.text!, password: password.text!) {
                    (user: PFUser?, error: NSError?) -> Void in
                    if let user = user {
                        print("log in sucessful")
                        
                        if user["isCook"]! as! Bool == true {
                            
                        
                        self.performSegue(withIdentifier: "toCook", sender: self)
                            print("segue")
                            
                        } else {
                            
                            self.performSegue(withIdentifier: "toFoodie", sender: self)
                            print("segue")
                            
                        }
                        
                        
                        
                    } else {
                        
                        if let errorString = error?.userInfo["error"] as? String {
                        
                            
                            
                            self.displayAlert("Log In Failed", message: errorString)
                        }

                        // The login failed. Check error to see why.
                    }
                }
        
        }
    

            
        }
        
    
    }

    
    
    
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var `switch`: UISwitch!
    @IBOutlet var foodieLabel: UILabel!
    @IBOutlet var cookLabel: UILabel!
    @IBOutlet var toLogIn: UIButton!
    
    @IBOutlet var alreadyMember: UILabel!
    @IBAction func toLogInButton(_ sender: AnyObject) {
        
        if signUpstate == true {
            
            nextSignUp.setTitle("Log In", for: UIControlState())
            toLogIn.setTitle("Sign Up", for: UIControlState())
            topLabel.text = "Log In"
            
            alreadyMember.text = "Not a Member?"
            signUpstate = false
            foodieLabel.alpha = 0
            cookLabel.alpha = 0
            `switch`.alpha = 0
            
        } else {
            
            nextSignUp.setTitle("Next", for: UIControlState())
            toLogIn.setTitle("Log In", for: UIControlState())
            
           alreadyMember.text = "Already a Member?"
            signUpstate = true
            foodieLabel.alpha = 1
            cookLabel.alpha = 1
            `switch`.alpha = 1
            
        }
        
    
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUp.DismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.email.delegate = self;
        self.password.delegate = self;
        
        
    }
    

    
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if signUpstate == false {
            
            nextSignUp.setTitle("Log In", for: UIControlState())
            toLogIn.setTitle("Sign Up", for: UIControlState())
            topLabel.text = "Log In"
            
             alreadyMember.text = "Not a Member?"
            foodieLabel.alpha = 0
            cookLabel.alpha = 0
            `switch`.alpha = 0
            
        } else {
            
            nextSignUp.setTitle("Next", for: UIControlState())
            toLogIn.setTitle("Log In", for: UIControlState())
            
             alreadyMember.text = "Already a Member?"
            foodieLabel.alpha = 1
            cookLabel.alpha = 1
            `switch`.alpha = 1
            
        }

        
        
}






    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
