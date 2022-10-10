//
//  MovieDetailView.swift
//  iTunes Client App
//
//  Created by Emiralp Duman on 7.10.2022.
//

import UIKit

final class MovieDetailView: UIView {
    var director: String? {
        didSet {
            directorKeyLabel.text = "Director:"
            directorKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            
            directorLabel.text = director ?? "-"
        }
    }
    
    var title: String? {
        didSet {
            titleKeyLabel.text = "Title:"
            titleKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            titleLabel.text = title ?? "-"
        }
    }
    
    var releaseDate: String? {
        didSet {
            releaseDateKeyLabel.text = "Release Date:"
            releaseDateKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            releaseDateLabel.text = releaseDate ?? "-"
        }
    }
    
    var contentAdvisoryRating: String? {
        didSet {
            contentAdvisoryRatingKeyLabel.text = "Rating:"
            contentAdvisoryRatingKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            contentAdvisoryRatingLabel.text = contentAdvisoryRating ?? "-"
        }
    }
    
    var longDescription: String? {
        didSet {
            longDescriptionKeyLabel.text = "Rating:"
            longDescriptionKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            longDescriptionLabel.text = contentAdvisoryRating ?? "-"
        }
    }
    
    private(set) var imageView = UIImageView()
    
    private let titleKeyLabel = UILabel()
    private let titleLabel = UILabel()
    private lazy var titleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleKeyLabel, UIView(), titleLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let directorKeyLabel = UILabel()
    private let directorLabel = UILabel()
    private lazy var directorStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [directorKeyLabel, UIView(), directorLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var releaseDateKeyLabel = UILabel()
    private var releaseDateLabel = UILabel()
    private lazy var releaseDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releaseDateKeyLabel, UIView(), releaseDateLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var contentAdvisoryRatingKeyLabel = UILabel()
    private var contentAdvisoryRatingLabel = UILabel()
    private lazy var contentAdvisoryRatingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [contentAdvisoryRatingKeyLabel, UIView(), contentAdvisoryRatingLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var longDescriptionKeyLabel = UILabel()
    private var longDescriptionLabel = UILabel()
    private lazy var longDescriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [longDescriptionKeyLabel, UIView(), longDescriptionLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        titleLabel.numberOfLines = .zero
        directorLabel.numberOfLines = .zero
        releaseDateLabel.numberOfLines = .zero
        contentAdvisoryRatingLabel.numberOfLines = .zero
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: .screenWidth)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [titleStackView,
                                                       directorStackView,
                                                       releaseDateStackView,
                                                       contentAdvisoryRatingStackView,
                                                       longDescriptionStackView])
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
