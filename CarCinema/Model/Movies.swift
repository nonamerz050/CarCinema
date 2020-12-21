//
//  Movies.swift
//  CarCinema
//
//  Created by MacBook Pro on 17.12.2020.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot
import Firebase

class Movie {
    var movieName: String
    var movieDuration: Int
    var movieDescription: String
    var movieGenre: String

    
    init(movieName: String, movieDescription: String, movieDuration: Int, movieGenre: String) {
        self.movieName = movieName
        self.movieDuration = movieDuration
        self.movieDescription = movieDescription
        self.movieGenre = movieGenre

    }
}

