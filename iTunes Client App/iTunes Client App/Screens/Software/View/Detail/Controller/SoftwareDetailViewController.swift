//
//  SoftwareDetailViewController.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 10.10.2022.
//

import UIKit
import CoreData


final class SoftwareDetailViewController: UIViewController {
    
    var items = [NSManagedObject]()

    
    var software: Software? {
        didSet {
            title = software?.trackName
            softwareDetailView.imageView.downloadImage(from: software?.artwork)
            softwareDetailView.releaseDate = software?.releaseDate
            softwareDetailView.artistName = software?.artistName
            softwareDetailView.primaryGenreName = software?.primaryGenreName
        }
    }
    
    private let softwareDetailView = SoftwareDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = softwareDetailView
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(addToFavourites))
    }
    
    @objc private func addToFavourites() {
        let values = ["artwork" : software?.artwork?.absoluteString as Any,
                      "type" : "software",
                      "title": software?.trackName! as Any] as [String : Any]
        
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
