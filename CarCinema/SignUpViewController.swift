//
//  SignInViewController.swift
//  CarCinema
//
//  Created by MacBook Pro on 26.11.2020.
//

import UIKit
import Firebase
import FirebaseAuth


class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
    }
    
//    func checkValid() -> String? {
//        if firstNameTextField.text == "" ||
//           lastNameTextField.text == "" ||
//           emailTextField.text == "" ||
//           passwordTextField.text == "" ||
//           firstNameTextField.text == nil ||
//           lastNameTextField.text == nil ||
//           emailTextField.text == nil ||
//           passwordTextField.text == nil {
//            return "Please fill in all fields"
//        }
//        return nil
//    }
    
    func register(email: String?, password: String?, completion: @escaping (AuthResult) -> Void) {
        
        guard let email = email, let password = password else {
            completion(.failure(AuthError.unknownError))
            return
        }
        
        guard Validators.isSimpleEmail(email) else {
            completion(.failure(AuthError.invalidEmail))
            return
            
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            guard let _ = result else {
                completion(.failure(error!))
                return
            }
            let db = Firestore.firestore()
            db.collection("users").addDocument(data: [
                "firstname": self.firstNameTextField.text!,
                "lastname": self.lastNameTextField.text!,
                "uid": result!.user.uid
            ]) { (error) in
                if let error = error {
                    completion(.failure(error))
                }
                completion(.success)
            }
        }
    }
    
    @IBAction func signInPressed(_ sender: Any) {
       
        register(email: emailTextField.text, password: passwordTextField.text) { (result) in
            switch result {
            case .success:
                self.showAlert(with: "Успешно", and: "Вы зарегистрированы", completion: {
                    let pageVC = MoviesTableViewController()
                    
            }
             )   case .failure: break
                    
            }
        }
        
        /*
        
        if checkValid() != nil {
            errorLabel.alpha = 1
            errorLabel.text = checkValid()
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, error) in
                if error != nil {
                    self.errorLabel.text = "\(error?.localizedDescription)"
                } else {
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: [
                        "firstname": self.firstNameTextField.text!,
                        "lastname": self.lastNameTextField.text!,
                        "uid": result!.user.uid
                    ]) { (error) in
                        if error != nil {
                            fatalError("Error saving user in database")
                        }
                    }
                    
                    
                    
                    print("Jump to the next screen")
                }
            }
        }
         */
    }
 

    

}
