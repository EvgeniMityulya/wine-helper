//
//  CatalogViewController.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/23/24.
//

import UIKit

protocol CatalogViewInput: AnyObject {
}

final class CatalogViewController: UIViewController {
    
    var output: CatalogViewOutput?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.CustomColors.background
        return view
    }()
    
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "topImageCatalog")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = contentView.bounds.size
        return scrollView
    }()
    
    private lazy var winesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var specialOfferSection: CatalogSection = {
        let section = CatalogSection(sectionName: "Special Offer", showSeeAllButton: true)
        section.translatesAutoresizingMaskIntoConstraints = false
        return section
    }()
    
    private lazy var newArrivalsSection: CatalogSection = {
        let section = CatalogSection(sectionName: "New Arrivals", showSeeAllButton: true)
        section.translatesAutoresizingMaskIntoConstraints = false
        return section
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .systemGray
        self.setupUI()
        self.navigationController?.navigationBar.isHidden = true
        
        specialOfferSection.seeAllButtonAction = { [weak self] in
            guard let self = self else { return }
            self.output?.specialOfferSeeAllButtonTouchUpInside()
        }
        
        newArrivalsSection.seeAllButtonAction = { [weak self] in
            guard let self = self else { return }
            self.output?.newArrivalsSeeAllButtonTouchUpInside()
        }
    }
}

extension CatalogViewController: CatalogViewInput {
}

private extension CatalogViewController {
    func setupUI() {
        self.view.addSubview(
            self.scrollView
        )
        
        self.scrollView.addSubview(
            self.contentView
        )
        
        self.contentView.addSubview(
            self.topImageView,
            self.winesStackView
        )
        
        self.winesStackView.addArrangedSubview(self.specialOfferSection)
        self.winesStackView.addArrangedSubview(self.newArrivalsSection)
        
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor),
            
            self.topImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.topImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.topImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.topImageView.heightAnchor.constraint(equalToConstant: 220),
            
            self.winesStackView.topAnchor.constraint(equalTo: self.topImageView.bottomAnchor, constant: 10),
            self.winesStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.winesStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.winesStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
        ])
    }
}
