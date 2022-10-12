//
//  EBookDetailViewController.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 10.10.2022.
//

import UIKit
import CoreData


final class EBookDetailViewController: UIViewController {
    
    var items = [NSManagedObject]()

    
    var eBook: EBook? {
        didSet {
            title = eBook?.trackName
            eBookDetailView.imageView.downloadImage(from: eBook?.artworkUrl100)
            eBookDetailView.releaseDate = eBook?.releaseDate
            eBookDetailView.artistName = eBook?.artistName
            eBookDetailView.eBookDescription = eBook?.eBookDescription
            eBookDetailView.genres = eBook?.genres?.reduce("") { $1 + ", " + $0 }


        }
    }
    
    private let eBookDetailView = EBookDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = eBookDetailView
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(addToFavourites))
    }
    
    @objc private func addToFavourites() {
        let values = ["artwork" : eBook?.artworkUrl100?.absoluteString as Any,
                      "type" : "eBook",
                      "title": eBook?.trackName! as Any] as [String : Any]
        
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
