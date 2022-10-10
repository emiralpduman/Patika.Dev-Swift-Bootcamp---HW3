//
//  MovieViewController.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 7.10.2022.
//

import UIKit

final class MovieViewController: UIViewController {
    
    // MARK: - Properties
    private let movieView = MovieView()
    private let networkService = BaseNetworkService()
    private var movieResponse: MovieResponse? {
        didSet {
            movieView.refresh()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Movies"
        view = movieView
        movieView.setCollectionViewDelegate(self, andDataSource: self)
        
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Genres, Titles, Directors..."
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        fetchMovies()
    }
    
    // MARK: - Methods
    private func fetchMovies(with text: String = "Gun") {
        networkService.request(MovieRequest(searchText: text)) { result in
            switch result {
            case .success(let response):
                self.movieResponse = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = MovieDetailViewController()
        detailViewController.movie = movieResponse?.results?[indexPath.row]
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieResponse?.results?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        let movie = movieResponse?.results?[indexPath.row]
        cell.title = movie?.title

        cell.imageView.downloadImage(from: movie?.artwork)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
} 

// MARK: - UISearchResultsUpdating
extension MovieViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            fetchMovies(with: text)
        }
    }
}
