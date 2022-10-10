//
//  MusicViewController.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 10.10.2022.
//

import UIKit

final class MusicViewController: UIViewController {
    
    // MARK: - Properties
    private let musicView = MusicView()
    private let networkService = BaseNetworkService()
    private var musicResponse: MusicResponse? {
        didSet {
            musicView.refresh()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Musics"
        view = musicView
        musicView.setCollectionViewDelegate(self, andDataSource: self)
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Enter some words to narrow results down"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        fetchMusics()
    }
    
    // MARK: - Methods
    private func fetchMusics(with text: String = "Universal") {
        networkService.request(MusicRequest(searchText: text)) { result in
            switch result {
            case .success(let response):
                self.musicResponse = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MusicViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = MusicDetailViewController()
        detailViewController.music = musicResponse?.results?[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension MusicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        musicResponse?.results?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MusicCollectionViewCell
        let music = musicResponse?.results?[indexPath.row]
        cell.title = music?.trackName

        cell.imageView.downloadImage(from: music?.artworkUrl100)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - UISearchResultsUpdating
extension MusicViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            fetchMusics(with: text)
        }
    }
}
