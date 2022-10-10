//
//  MusicDetailViewController.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 10.10.2022.
//

import UIKit
import CoreData


final class MusicDetailViewController: UIViewController {
    
    var items = [NSManagedObject]()

    
    var music: Music? {
        didSet {
            title = music?.trackName
            musicDetailView.imageView.downloadImage(from: music?.artworkUrl100)
            musicDetailView.releaseDate = music?.releaseDate
            musicDetailView.artistName = music?.artistName
            musicDetailView.collectionName = music?.collectionName
            musicDetailView.primaryGenreName = music?.primaryGenreName
        }
    }
    
    private let musicDetailView = MusicDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = musicDetailView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(addToFavourites))
    }
    
    @objc private func addToFavourites() {
        let values = ["artwork" : music?.artworkUrl100?.absoluteString as Any,
                      "type" : "music",
                      "title": music?.trackName! as Any] as [String : Any]
        
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
