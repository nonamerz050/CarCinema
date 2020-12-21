//
//  MovieDetailViewController.swift
//  CarCinema
//
//  Created by MacBook Pro on 21.12.2020.
//

import UIKit
import Firebase
import FirebaseStorage

class MovieDetailViewController: UIViewController {

    var movie: Movie!
    
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieNameLabel.text = movie.movieName
        movieGenreLabel.text = movie.movieGenre
        
    
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
