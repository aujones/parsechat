//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Audrey Jones on 6/26/17.
//  Copyright © 2017 Audrey Jones. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signUpInitiated(_ sender: Any) {
        let newUser = PFUser()
        let alertController = UIAlertController(title: "Empty field", message: "You left the username or password field empty", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        if (username.text?.isEmpty)! || (password.text?.isEmpty)! {
            present(alertController, animated: true)
        }
        newUser.username = username.text
        newUser.password = password.text
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
                let alertController2 = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                }
                alertController2.addAction(cancelAction)
                self.present(alertController2, animated: true)
                
            }
            else {
                print("User registered successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        
    }
    
    
    @IBAction func logInInitiated(_ sender: Any) {
        let username = self.username.text ?? ""
        let password = self.password.text ?? ""
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
            if let error = error {
                print("User login failed: \(error.localizedDescription)")
                print(error.localizedDescription)
                let alertController2 = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
                }
                alertController2.addAction(cancelAction)
                self.present(alertController2, animated: true)
            }
            else {
                print("User login successful")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
