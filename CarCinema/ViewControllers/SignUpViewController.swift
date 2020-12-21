//
//  SignInViewController.swift
//  CarCinema
//
//  Created by MacBook Pro on 26.11.2020.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

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
        firstNameTextField.textColor = .black
        lastNameTextField.textColor = .black
        emailTextField.textColor = .black
        passwordTextField.textColor = .black
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        // check that all fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields"
        }
        
        // Check if the password is secure
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Пароль должен быть не менее 6 символов, а так же должен содержать специальные символы и цифры"
        }
        
        return nil
    }
    
    // Password validation
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,}")
        return passwordTest.evaluate(with: password)
    }
    
    
    
    
  /*  func register(email: String?, password: String?, completion: @escaping (AuthResult) -> Void) {
        
        guard Validators.isFilled(firstname: firstNameTextField.text, lastName: lastNameTextField.text, email: emailTextField.text, password: passwordTextField.text) else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
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
    } */
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func tapKeyboardOff(_ sender: Any) {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    @available(iOS 13.0, *)
    @IBAction func signInPressed(_ sender: Any) {
        
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with fields, show error message
            showError(error!)
        }
        else {
            
            // Create cleaned versiond of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            
            // Create the user
        
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // Check for errors
                if err != nil {
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid": result!.user.uid]) { (error) in
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    
                    // Transition to the home screen
                    self.transitionToHome()
                }
            }
            
        // Transition to the home screen
       
        }
        
        
        
       /* register(email: emailTextField.text, password: passwordTextField.text) { (result) in
            switch result {
            case .success:
                self.showAlert(with: "Успешно", and: "Вы зарегистрированы", completion: {
                    let pageVC = MoviesTableViewController()
                    self.present(pageVC, animated: true, completion: nil)
                })
            case .failure(let error):
                self.showAlert(with: "Ошибка", and: error.localizedDescription)
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
         */
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }

    @available(iOS 13.0, *)
    func transitionToHome() {
        
        let moviesTableViewController =
            storyboard?.instantiateViewController(identifier: Constants.Storyboard.moviesTableViewController) as? MoviesTableViewController
        
        view.window?.rootViewController = moviesTableViewController
        view.window?.makeKeyAndVisible()
        
    }
    

}
