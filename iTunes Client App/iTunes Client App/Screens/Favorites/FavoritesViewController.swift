//
//  FavoritesViewController.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 10.10.2022.
//

import UIKit
import CoreData

class FavoritesViewController: UIViewController, UICollectionViewDelegate {
    
    private let favoritesView = FavoritesView()
    
    private var favourites = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorites"
        view = favoritesView
        favoritesView.setCollectionViewDelegate(self, andDataSource: self)
        
        fetchItems()
    }
    
    
    // MARK: - Methods
    private func fetchItems() {
        DBOps.shared.read() { objects, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let objects = objects else {
                return
            }
            self.favourites = objects
        }
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


// MARK: - UICollectionViewDataSource
extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favourites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PodcastCollectionViewCell
        let favorite = favourites[indexPath.row]
        cell.title = favorite.value(forKey: "title") as? String
        cell.imageView.downloadImage(from: URL(string: favorite.value(forKey: "artwork") as! String))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}

