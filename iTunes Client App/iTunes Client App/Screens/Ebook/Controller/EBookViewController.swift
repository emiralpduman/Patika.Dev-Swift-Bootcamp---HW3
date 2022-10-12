//
//  EBookViewController.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 10.10.2022.
//

import UIKit

final class EBookViewController: UIViewController {
    
    // MARK: - Properties
    private let eBookView = EBookView()
    private let networkService = BaseNetworkService()
    private var eBookResponse: EBookResponse? {
        didSet {
            eBookView.refresh()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "EBooks"
        view = eBookView
        eBookView.setCollectionViewDelegate(self, andDataSource: self)
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Enter some words to narrow results down"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        fetchEBooks()
    }
    
    // MARK: - Methods
    private func fetchEBooks(with text: String = "Universal") {
        networkService.request(EBookRequest(searchText: text)) { result in
            switch result {
            case .success(let response):
                self.eBookResponse = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension EBookViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = EBookDetailViewController()
        detailViewController.eBook = eBookResponse?.results?[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension EBookViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        eBookResponse?.results?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EBookCollectionViewCell
        let eBook = eBookResponse?.results?[indexPath.row]
        cell.title = eBook?.trackName

        cell.imageView.downloadImage(from: eBook?.artworkUrl100)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - UISearchResultsUpdating
extension EBookViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            fetchEBooks(with: text)
        }
    }
}
