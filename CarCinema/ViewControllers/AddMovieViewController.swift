//
//  AddMovieViewController.swift
//  CarCinema
//
//  Created by MacBook Pro on 14.12.2020.
//

import UIKit
import FirebaseStorage
import Firebase

class AddMovieViewController: UIViewController {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var movieNameTextField: UITextField!
    @IBOutlet weak var movieGenreTextField: UITextField!
    @IBOutlet weak var movieDurationTextField: UITextField!
    @IBOutlet weak var movieDescriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieImage.layer.cornerRadius = 10
        movieImage.layer.borderWidth = 0.5
        movieNameTextField.textColor = .black
        movieGenreTextField.textColor = .black
        movieDurationTextField.textColor = .black
        movieDescriptionTextField.textColor = .black
    }
    
    func upload(currentUserID: String, photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        let ref = Storage.storage().reference().child("movies").child(currentUserID)
        guard let imageData = movieImage.image?.jpegData(compressionQuality: 0.4) else { return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        ref.putData(imageData, metadata: metadata) { (metadata, error) in
            guard let _ = metadata else {
                completion(.failure(error!))
                return
            }
            ref.downloadURL { (url, error) in
                guard let url = url else {
                    completion(.failure(error!))
                    return
                }
                completion(.success(url))
            }
        }
    }
    
    @IBAction func tapKeyboardOff(_ sender: Any) {
        movieNameTextField.resignFirstResponder()
        movieGenreTextField.resignFirstResponder()
        movieDurationTextField.resignFirstResponder()
        movieDescriptionTextField.resignFirstResponder()


    }
    @IBAction func uploadButtonTapped(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate  = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        let db = Firestore.firestore()
        let movieName = movieNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let movieGenre = movieGenreTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let movieDuration = movieDurationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let movieDescription = movieDescriptionTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        
        db.collection("Movies").document().setData([
            "movieName" : movieName,
            "movieGenre": movieGenre,
            "movieDuration": movieDuration,
            "movieDescription": movieDescription
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        
    }
}

extension AddMovieViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        movieImage.image = image
    }
}
