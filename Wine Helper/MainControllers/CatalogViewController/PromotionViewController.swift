//
//  CatalogViewController.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/23/24.
//

import UIKit

protocol PromotionInput: AnyObject {
}

final class PromotionViewController: UIViewController {
    
    var output: PromotionViewOutput?
    
    let specialSectionLoadingIndicator = UIActivityIndicatorView(style: .medium)
    
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
        scrollView.showsVerticalScrollIndicator = false
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
    
    private lazy var specialOfferSection: PromotionSection = {
        let section = PromotionSection(sectionName: "Special Offer")
        section.translatesAutoresizingMaskIntoConstraints = false
        return section
    }()
    
    private lazy var newArrivalsSection: PromotionSection = {
        let section = PromotionSection(sectionName: "New Arrivals")
        section.translatesAutoresizingMaskIntoConstraints = false
        return section
    }()
    
    private lazy var bestSellersSection: PromotionSection = {
        let section = PromotionSection(sectionName: "Best Sellers")
        section.translatesAutoresizingMaskIntoConstraints = false
        return section
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.CustomColors.background
        
        self.setupUI()
        self.configureActions()
        NetworkManager.shared.getWineSectionCells { [weak self] result in
            switch result {
            case .success(let wineCellDTOs):
                self?.fetchImagesForWineCellDTOs(wineCellDTOs, section: self?.specialOfferSection)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
//        NetworkManager.shared.getWineSectionCells { [weak self] result in
//            switch result {
//            case .success(let wineCellDTOs):
//                self?.fetchImagesForWineCellDTOs(wineCellDTOs, section: self?.newArrivalsSection)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//        
//        NetworkManager.shared.getWineSectionCells { [weak self] result in
//            switch result {
//            case .success(let wineCellDTOs):
//                self?.fetchImagesForWineCellDTOs(wineCellDTOs, section: self?.specialOfferSection)
//                
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func configureActions() {
        self.configureButtonsSeeAll()
        self.configureCollectionViewCellActions()
    }
    
    private func configureButtonsSeeAll() {
        specialOfferSection.seeAllButtonAction = { [weak self] in
            guard let self = self else { return }
            self.output?.specialOfferSeeAllButtonTouchUpInside()
        }
        
        newArrivalsSection.seeAllButtonAction = { [weak self] in
            guard let self = self else { return }
            self.output?.newArrivalsSeeAllButtonTouchUpInside()
        }
        
        bestSellersSection.seeAllButtonAction = { [weak self] in
            guard let self = self else { return }
            self.output?.newArrivalsSeeAllButtonTouchUpInside()
        }
    }
    
    private func configureCollectionViewCellActions() {
        specialOfferSection.cellSelectionHandler = { model in
            self.output?.collectionViewCellTouchUpInside(model: model)
        }
    }
    
    private func fetchImagesForWineCellDTOs(_ wineCellDTOs: [WineCellDTO], section: PromotionSection?) {
        specialOfferSection.setLoadingIndicatorVisible(true)
        let dispatchGroup = DispatchGroup()
        var wines: [WineCellDTO] = []
        var images: [UIImage] = []
        
        for wineCellDTO in wineCellDTOs {
            guard let id = wineCellDTO.id else { continue }
            
            dispatchGroup.enter()
            
            NetworkManager.shared.getWineImage(id: id) { result in
                defer { dispatchGroup.leave() }
                
                switch result {
                case .success(let image):
                    wines.append(wineCellDTO)
                    images.append(image)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Success")
            section?.setLoadingIndicatorVisible(false)
            section?.setWines(wines, images)
        }
    }
}

extension PromotionViewController: PromotionInput {
}

private extension PromotionViewController {
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
        
        self.winesStackView.addArrangedSubviews(
            self.specialOfferSection,
            self.newArrivalsSection,
            self.bestSellersSection
        )
        
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
            
            self.topImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.topImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            self.topImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            self.topImageView.heightAnchor.constraint(equalToConstant: 220),
            
            self.winesStackView.topAnchor.constraint(equalTo: self.topImageView.bottomAnchor, constant: 10),
            self.winesStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.winesStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.winesStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
        ])
    }
}
