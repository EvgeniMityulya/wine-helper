//
//  CatalogSection.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/13/24.
//

import UIKit

class CatalogSection: UIView {
    
    private let sectionName: String
    private let showSeeAllButton: Bool
    
    var seeAllButtonAction: (() -> Void)?
    
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
        attributedTitle.addAttribute(.foregroundColor, value: UIColor.gray, range: NSRange(location: 0, length: attributedTitle.length))
        attributedTitle.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedTitle.length))
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(seeAllButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func seeAllButtonTapped() {
        self.seeAllButtonAction?()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(sectionName: String, showSeeAllButton: Bool) {
        self.sectionName = sectionName
        self.showSeeAllButton = showSeeAllButton
        super.init(frame: .zero)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(self.titleLabel)
        
        if self.showSeeAllButton {
            self.addSubview(self.seeAllButton)
        }
        
        self.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            self.titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: self.showSeeAllButton ? -50 : -10),
            
            self.collectionView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
            self.collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        if self.showSeeAllButton {
            NSLayoutConstraint.activate([
                self.seeAllButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
                self.seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
            ])
        }
    }
}
