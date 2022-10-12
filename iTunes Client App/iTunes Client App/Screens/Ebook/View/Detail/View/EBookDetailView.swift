//
//  EBookDetailView.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 10.10.2022.
//

import UIKit

final class EBookDetailView: UIView {
    var trackName: String? {
        didSet {
            trackNameKeyLabel.text = "Release Date:"
            trackNameKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            trackNameLabel.text = trackName ?? "-"
        }
    }
    
    var artistName: String? {
        didSet {
            artistNameKeyLabel.text = "Artist Name:"
            artistNameKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            artistNameLabel.text = artistName ?? "-"
        }
    }
    
    var releaseDate: String? {
        didSet {
            releaseDateKeyLabel.text = "Release Date:"
            releaseDateKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            releaseDateLabel.text = releaseDate ?? "-"
        }
    }
    
    var eBookDescription: String? {
        didSet {
            eBookDescriptionKeyLabel.text = "Release Date:"
            eBookDescriptionKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            eBookDescriptionLabel.text = releaseDate ?? "-"
        }
    }
    
    var genres: String? {
        didSet {
            genresKeyLabel.text = "Genres:"
            genresKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            genresLabel.text = genres ?? "-"
        }
    }
    
    
    private(set) var imageView = UIImageView()
    
    private let releaseDateKeyLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private lazy var releaseDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releaseDateKeyLabel, UIView(), releaseDateLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let trackNameKeyLabel = UILabel()
    private let trackNameLabel = UILabel()
    private lazy var trackNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [trackNameKeyLabel, UIView(), trackNameLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var artistNameKeyLabel = UILabel()
    private var artistNameLabel = UILabel()
    private lazy var artistNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [artistNameKeyLabel, UIView(), artistNameLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let eBookDescriptionKeyLabel = UILabel()
    private let eBookDescriptionLabel = UILabel()
    private lazy var eBookDescriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [eBookDescriptionKeyLabel, UIView(), eBookDescriptionLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var genresKeyLabel = UILabel()
    private var genresLabel = UILabel()
    private lazy var genresStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genresKeyLabel, UIView(), genresLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        releaseDateLabel.numberOfLines = .zero
        trackNameLabel.numberOfLines = .zero
        artistNameLabel.numberOfLines = .zero
        eBookDescriptionLabel.numberOfLines = .zero
        artistNameLabel.numberOfLines = .zero

        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: .screenWidth)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [releaseDateStackView,
                                                       trackNameStackView,
                                                       artistNameStackView,
                                                      eBookDescriptionStackView,
                                                       genresStackView])
        stackView.axis = .vertical
        stackView.spacing = 8.0
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32.0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
