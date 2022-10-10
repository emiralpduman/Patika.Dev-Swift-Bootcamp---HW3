//
//  SoftwareViewController.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 10.10.2022.
//

import UIKit

final class SoftwareViewController: UIViewController {
    
    // MARK: - Properties
    private let softwareView = SoftwareView()
    private let networkService = BaseNetworkService()
    private var softwareResponse: SoftwareResponse? {
        didSet {
            softwareView.refresh()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Softwares"
        view = softwareView
        softwareView.setCollectionViewDelegate(self, andDataSource: self)
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Enter some words to narrow results down"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        fetchSoftwares()
    }
    
    // MARK: - Methods
    private func fetchSoftwares(with text: String = "Apple") {
        networkService.request(SoftwareRequest(searchText: text)) { result in
            switch result {
            case .success(let response):
                self.softwareResponse = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension SoftwareViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = SoftwareDetailViewController()
        detailViewController.software = softwareResponse?.results?[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension SoftwareViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        softwareResponse?.results?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SoftwareCollectionViewCell
        let software = softwareResponse?.results?[indexPath.row]
        cell.title = software?.trackName

        cell.imageView.downloadImage(from: software?.artwork)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - UISearchResultsUpdating
extension SoftwareViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            fetchSoftwares(with: text)
        }
    }
}
