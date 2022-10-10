//
//  MovieDetailViewController.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 7.10.2022.
//

import UIKit
import CoreData


final class MovieDetailViewController: UIViewController {
    
    var items = [NSManagedObject]()

    
    var movie: Movie? {
        didSet {
            title = movie?.title
            /*
            detailView.imageView.downloadImage(from: movie?.artwork)
             */
            detailView.releaseDate = movie?.releaseDate
            detailView.director = movie?.director
            detailView.contentAdvisoryRating = movie?.contentAdvisoryRating
            detailView.longDescription = movie?.longDescription
        }
    }
    
    private let detailView = MovieDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(addToFavourites))
    }
    
    
    @objc private func addToFavourites() {
        let values = ["artwork" : movie?.artwork?.absoluteString as Any,
                      "type" : "movie",
                      "title": movie?.title! as Any] as [String : Any]
        
        DBOps.shared.create(entityName: "Favorite",
                            values: values as [String : Any]) { object, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let object = object else {
                return
            }
            self.items.append(object)
        }
        
    }
}
