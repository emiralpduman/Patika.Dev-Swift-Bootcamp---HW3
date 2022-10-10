//
//  DetailViewController.swift
//  iTunes Client App
//
//  Created by Pazarama iOS Bootcamp on 2.10.2022.
//

import UIKit
import CoreData

final class DetailViewController: UIViewController {
    
    var items = [NSManagedObject]()
    
    var podcast: Podcast? {
        didSet {
            title = podcast?.trackName
            detailView.imageView.downloadImage(from: podcast?.artworkLarge)
            detailView.releaseDate = podcast?.releaseDate
            detailView.artistName = podcast?.artistName
            detailView.country = podcast?.country
            detailView.genres = podcast?.genres?.reduce("") { $1 + ", " + $0 }
        }
    }
    
    private let detailView = DetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(addToFavourites))
        
        
    }
    
    @objc private func addToFavourites() {
        let values = ["artwork" : podcast?.artworkLarge?.absoluteString as Any,
                      "type" : "podcast",
                      "title": podcast?.trackName! as Any] as [String : Any]
        
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
