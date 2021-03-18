//
//  MoviesTableViewController.swift
//  CarCinema
//
//  Created by MacBook Pro on 02.12.2020.
//

import UIKit
import Firebase
import FirebaseStorage

class MoviesTableViewController: UITableViewController {
    
  
    
    @IBOutlet weak var moviesList: UITableView!
    
    var ref: DatabaseReference?
    var weekDayRef: DatabaseReference?
    var movies = [Movie]()
    var weekday = [WeekDay]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        ref = Database.database().reference().child("Monday")
        ref?.observe(.childAdded){ [weak self](snapshot) in
            let key = snapshot.key
            guard let value = snapshot.value as? [String: Any] else {return}
            if let movieDescription = value["description"] as? String, let movieDuration = value["duration"] as? Int, let movieGenre = value["genre"] as? String  {
                let movie = Movie(movieName: key, movieDescription: movieDescription, movieDuration: movieDuration, movieGenre: movieGenre)
                self?.movies.append(movie)
                if let row = self?.movies.count {
                let indexPath = IndexPath(row: row-1, section: 0)
                    self?.tableView.insertRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }

    // MARK: - Setup NavigationBar
    
    private func setupNavigationBar() {
        navigationItem.title = "Расписание"
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        cell.textLabel?.text = movie.movieName
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.text = movie.movieGenre
        cell.detailTextLabel?.textColor = .white
        
        return cell
    }


    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        let movieDetailsVC = segue.destination as! MovieDetailViewController
        movieDetailsVC.movie = movies[indexPath.row]
        
    }

}
