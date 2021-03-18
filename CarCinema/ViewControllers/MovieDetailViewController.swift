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
    @IBOutlet weak var movieDurationLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieNameLabel.text = movie.movieName
        movieGenreLabel.text = "Жанр: \(movie.movieGenre)"
        movieDurationLabel.text = "Длительность: \(movie.movieDuration) мин."
        movieDescriptionLabel.text = movie.movieDescription
    }

}
