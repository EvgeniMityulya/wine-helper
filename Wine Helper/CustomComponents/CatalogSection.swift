//
//  CatalogSection.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/13/24.
//

import UIKit

struct WineSelectionInfo {
    let image: UIImage
    let id: Int
}

class WineCell: UICollectionViewCell {
    private lazy var cellBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.CustomColors.detailsBackgroundColor
        view.layer.cornerRadius = 10
        view.layer.zPosition = -1
        
        view.layer.shadowColor = UIColor.CustomColors.shadowColor.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10
        return view
    }()
    
    private lazy var wineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "wine")
        imageView.layer.zPosition = 2
        return imageView
    }()
    
    private lazy var wineBrandLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.zPosition = 1
        label.font = .playfair(ofSize: 14, style: .medium)
        return label
    }()
    
    private lazy var wineNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.zPosition = 1
        label.font = .playfair(ofSize: 16, style: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with wine: WineCellDTO, image: UIImage?) {
        DispatchQueue.main.async {
            self.wineImageView.image = image
            
            if let name = wine.name, let yearProduced = wine.yearProduced, let prod = wine.prod {
                self.wineBrandLabel.attributedText = NSAttributedString.attributedString(
                    withText: prod,
                    spacing: 2.0
                )
                
                self.wineNameLabel.attributedText = NSAttributedString.attributedString(
                    withText: name + " " + String(yearProduced),
                    spacing: 1.5
                )
            }
        }
    }
    
    private func setupUI() {
        self.contentView.addSubview(wineBrandLabel)
        self.contentView.addSubview(wineNameLabel)
        self.contentView.addSubview(wineImageView)
        self.contentView.addSubview(cellBackgroundView)
        
        NSLayoutConstraint.activate([
            wineImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            wineImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            wineImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            wineImageView.bottomAnchor.constraint(equalTo: self.wineBrandLabel.topAnchor, constant: -10),
            
            wineBrandLabel.bottomAnchor.constraint(equalTo: self.wineNameLabel.topAnchor),
            wineBrandLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            wineBrandLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            wineBrandLabel.heightAnchor.constraint(equalToConstant: 20),
            
            wineNameLabel.bottomAnchor.constraint(equalTo: self.cellBackgroundView.bottomAnchor, constant: -5),
            wineNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            wineNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            wineNameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            cellBackgroundView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            cellBackgroundView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            cellBackgroundView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            cellBackgroundView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.85),
        ])
    }
}

class CatalogSection: UIView {
    
    private let sectionName: String
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var seeAllButtonAction: (() -> Void)?
    var cellSelectionHandler: ((WineSelectionInfo) -> Void)?
    
    private var wines: [WineCellDTO] = []
    private var images: [UIImage] = []
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.sectionName
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var seeAllButton: UIButton = {
        let button = UIButton()
        let attributedTitle = NSMutableAttributedString(string: "See All")
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        attributedTitle.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedTitle.length))
        
        attributedTitle.addAttribute(.font, value: UIFont.systemFont(ofSize: 14, weight: .bold), range: NSRange(location: 0, length: attributedTitle.length))
        attributedTitle.addAttribute(.foregroundColor, value: UIColor.CustomColors.burgundy, range: NSRange(location: 0, length: attributedTitle.length))
        attributedTitle.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedTitle.length))
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WineCell.self, forCellWithReuseIdentifier: "WineCell")
        return collectionView
    }()
    
    
    @objc private func seeAllButtonTapped() {
        self.seeAllButtonAction?()
    }
    
    init(sectionName: String) {
        self.sectionName = sectionName
        super.init(frame: .zero)
        self.setupUI()
    }
    
    func setLoadingIndicatorVisible(_ isVisible: Bool) {
        if isVisible {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
        }
    }
    
    func setWines(_ wines: [WineCellDTO], _ images: [UIImage]) {
        self.wines = wines
        self.images = images
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CatalogSection: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedWine = wines[indexPath.item]
        let image = images[indexPath.item]
        
        let selectionInfo = WineSelectionInfo(image: image, id: selectedWine.id ?? 0)
        
        cellSelectionHandler?(selectionInfo)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.wines.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WineCell", for: indexPath) as! WineCell
        let wine = self.wines[indexPath.item]
        let image = self.images[indexPath.item]
        cell.configure(with: wine, image: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = (collectionView.bounds.width - 80) / 2
        let cellHeight: CGFloat = 250
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    
}

private extension CatalogSection {
    func setupUI() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.seeAllButton)
        self.addSubview(self.collectionView)
        self.addSubview(self.loadingIndicator)
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            self.titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            self.titleLabel.trailingAnchor.constraint(equalTo: seeAllButton.leadingAnchor, constant: -10),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            self.seeAllButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            self.seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            self.seeAllButton.widthAnchor.constraint(equalToConstant: 50),
            
            self.collectionView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: 270),
            
            self.loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            self.loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
