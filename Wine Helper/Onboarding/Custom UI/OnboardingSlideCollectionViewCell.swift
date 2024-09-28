//
//  OnboardingSlideCollectionViewCell.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/25/24.
//

import UIKit

final class OnboardingSlideCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingViewController.self)
    
    private lazy var slideImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.zPosition = 2
        return imageView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.zPosition = 1
        label.font = .openSans(ofSize: 26, style: .bold)
        
        
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: 30),
        ])
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.layer.zPosition = 1
        label.font = .openSans(ofSize: 20, style: .semiBold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with slide: OnboardingSlide) {
        DispatchQueue.main.async {
            self.slideImageView.image = slide.image
            self.titleLabel.text = slide.title
            self.descriptionLabel.text = slide.desciption
        }
    }
}

private extension OnboardingSlideCollectionViewCell {
    func setupUI() {
        self.addSubview(
            self.slideImageView,
            self.stackView
        )
        
        self.stackView.addArrangedSubviews(
            self.titleLabel,
            self.descriptionLabel
        )
        
        NSLayoutConstraint.activate([
            self.slideImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.slideImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.slideImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.slideImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.6),
            
            self.stackView.topAnchor.constraint(equalTo: self.slideImageView.bottomAnchor, constant: 40),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}
