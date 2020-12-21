//
//  LoginViewController.swift
//  CarCinema
//
//  Created by MacBook Pro on 26.11.2020.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        
        emailTextField.textColor = .black
        passwordTextField.textColor = .black
    }
    // переход по сигвею
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "moviesVC"{
//            let
//        }
//    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func tapKeyboardOff(_ sender: Any) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    @available(iOS 13.0, *)
    @IBAction func loginButtonPressed(_ sender: Any) {
        // Validate text fields
        
        
        // Create cleaned versions of the text field
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing the user
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            } else {
                
                let moviesTableViewController =
                    self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.moviesTableViewController) as? MoviesTableViewController
                
//                let moviesTableViewController =
//                    self.storyboard?.instantiateViewControllr
                self.view.window?.rootViewController = moviesTableViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
        
       // SwiftBook exapmle
    
    /*    Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
            if error != nil {
                
            } else {
                
            }
        } */
        
    }
    
    
    

}
