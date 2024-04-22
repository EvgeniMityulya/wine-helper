//
//  WineViewController.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/20/24.
//

import UIKit

protocol WineViewInput: AnyObject {
}

final class WineViewController: UIViewController {
    
    var wineModel: Wine = Wine(
        brand: "Chateau Margaux",
        name: "Grand Vin",
        category: "Dry Red",
        description: "An elegant wine with aromas of blackcurrant, cherry and oak, with soft tannins and a long aftertaste.",
        alcoholPl: 13.5,
        rating: 4.68,
        sweetness: 2,
        bitterness: 3,
        acidity: 4,
        country: "France",
        region: "Bordeaux",
        grapeVarieties: ["Cabernet Sauvignon", "Merlot", "Petit Verdot"],
        harvestDate: 2020,
        recommendations: "Perfect for pairing red meats and cheeses.",
        price: 300
    )
    
    var output: WineViewOutput?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.CustomColors.background
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = UIColor.CustomColors.background
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = contentView.bounds.size
        return scrollView
    }()
    
    private lazy var winePictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "wine")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        // Добавляем тень
        imageView.layer.shadowColor = UIColor.CustomColors.shadowColor.cgColor
        imageView.layer.shadowOffset = CGSize(width: 0, height: 8)
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 10
        
        //        let width: CGFloat = 75
        //        let height: CGFloat = 300
        //
        //        let shadowSize: CGFloat = 20
        //        let shadowDistance: CGFloat = 20
        //        let contactRect = CGRect(x: 50 - shadowSize, y: height - (shadowSize * 0.4), width: width + shadowSize, height: shadowSize)
        //        imageView.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        //        imageView.layer.shadowRadius = 5
        //        imageView.layer.shadowOpacity = 0.6
        imageView.layer.masksToBounds = false
        
        
        return imageView
    }()
    
    private lazy var wineBrandLabel: UILabel = {
        let label = UILabel()
        let text = wineModel.brand
        label.attributedText = NSAttributedString.attributedString(withText: text, spacing: 2.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .playfair(ofSize: 23, style: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var wineNameLabel: UILabel = {
        let label = UILabel()
        let text = wineModel.name + " " + String(wineModel.harvestDate)
        label.attributedText = NSAttributedString.attributedString(withText: text, spacing: 2.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .playfair(ofSize: 23, style: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var winePriceLabel: UILabel = {
        let label = UILabel()
        let text = "$ " + String(self.wineModel.price)
        label.attributedText = NSAttributedString.attributedString(withText: text, spacing: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoFlex(ofSize: 17, style: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var wineAlcoholLabel: UILabel = {
        let label = UILabel()
        label.text = String(wineModel.alcoholPl) + " % alc."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .playfair(ofSize: 19, style: .regular)
        label.numberOfLines = 0
        label.layer.zPosition = 1
        return label
    }()
    
    private lazy var wineDetailsContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.CustomColors.detailsBackgroundColor
        view.layer.cornerRadius = 100
        view.layer.zPosition = 0
        
        view.layer.shadowColor = UIColor.CustomColors.shadowColor.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 10
        
        return view
    }()
    
    private lazy var countryLabel: UILabel = {
        let label = UILabel()
        label.text = "Country"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.CustomColors.burgundy
        label.font = .robotoFlex(ofSize: 15, style: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var regionLabel: UILabel = {
        let label = UILabel()
        label.text = "Region"
        label.textColor = UIColor.CustomColors.burgundy
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoFlex(ofSize: 15, style: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.textColor = UIColor.CustomColors.burgundy
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .robotoFlex(ofSize: 15, style: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var wineCountryLabel: UILabel = {
        let label = UILabel()
        label.text = wineModel.country
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .playfair(ofSize: 19, style: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var wineRegionLabel: UILabel = {
        let label = UILabel()
        label.text = wineModel.region
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .playfair(ofSize: 19, style: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var wineCategoryLabel: UILabel = {
        let label = UILabel()
        label.text = wineModel.category
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .playfair(ofSize: 19, style: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var wineFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var wineCountryFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 1
        return stackView
    }()
    
    private lazy var wineRegionFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 1
        return stackView
    }()
    
    private lazy var wineCategoryFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 1
        return stackView
    }()
    
    private lazy var wineDescriptionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        stackView.backgroundColor = UIColor.CustomColors.background
        
        stackView.layer.shadowColor = UIColor.CustomColors.shadowColor.cgColor
        stackView.layer.shadowOffset = CGSize(width: 0, height: 3)
        stackView.layer.shadowOpacity = 0.1
        stackView.layer.shadowRadius = 10
        
        stackView.layer.cornerRadius = 10
        
        return stackView
    }()
    
    private lazy var wineRatingStarsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 40)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        for _ in 0..<5 {
            let starImageView = UIImageView(image: SystemImage.star.image)
            starImageView.tintColor = UIColor.CustomColors.burgundy
            stackView.addArrangedSubview(starImageView)
        }
        return stackView
    }()
    
    private lazy var wineDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = wineModel.description
        label.numberOfLines = 0
        label.font = .playfair(ofSize: 14, style: .regular)
        return label
    }()
    
    private lazy var grapesVarietiesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let text = "Grapes varieties"
        label.attributedText = NSAttributedString.attributedString(withText: text, spacing: 2.0)
        label.numberOfLines = 0
        label.font = .playfair(ofSize: 22, style: .semiBold)
        return label
    }()
    
    private lazy var wineGrapeVarietiesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private lazy var characteristicsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let text = "Characteristics"
        label.attributedText = NSAttributedString.attributedString(withText: text, spacing: 2.0)
        label.numberOfLines = 0
        label.font = .playfair(ofSize: 22, style: .semiBold)
        return label
    }()
    
    private lazy var wineCharacteristicsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        stackView.backgroundColor = UIColor.CustomColors.background
        
        stackView.layer.shadowColor = UIColor.CustomColors.shadowColor.cgColor
        stackView.layer.shadowOffset = CGSize(width: 0, height: 3)
        stackView.layer.shadowOpacity = 0.1
        stackView.layer.shadowRadius = 10
        
        stackView.layer.cornerRadius = 10
        
        return stackView
    }()
    
    private lazy var wineSweetnessFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 1
        return stackView
    }()
    
    private lazy var sweetnessLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sweetness"
        label.numberOfLines = 0
        label.font = .playfair(ofSize: 14, style: .regular)
        return label
    }()
    
    private lazy var wineSweetnessLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(wineModel.sweetness) + " / 5"
        label.numberOfLines = 0
        label.font = .playfair(ofSize: 14, style: .regular)
        return label
    }()
    
    private lazy var wineBitternessFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 1
        return stackView
    }()
    
    private lazy var bitternessLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bitterness"
        label.numberOfLines = 0
        label.font = .playfair(ofSize: 14, style: .regular)
        return label
    }()
    
    private lazy var wineBitternessLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(wineModel.bitterness) + " / 5"
        label.numberOfLines = 0
        label.font = .playfair(ofSize: 14, style: .regular)
        return label
    }()
    
    private lazy var wineAcidityFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 1
        return stackView
    }()
    
    private lazy var acidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Acidity"
        label.numberOfLines = 0
        label.font = .playfair(ofSize: 14, style: .regular)
        return label
    }()
    
    private lazy var wineAcidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = String(wineModel.acidity) + " / 5"
        label.numberOfLines = 0
        label.font = .playfair(ofSize: 14, style: .regular)
        return label
    }()
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.CustomColors.background
        self.setupUI()
        DispatchQueue.main.async {
            self.fillStars(with: self.wineModel.rating)
            self.fillGrapeVarieties(with: self.wineModel.grapeVarieties)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NetworkManager.shared.getWine(with: 2) { result in
            switch result {
            case .success(let wineDTOs):
                print(wineDTOs)
            case .failure(let error):
                // Обработка ошибки при запросе
                print("Failed to fetch wine: \(error.localizedDescription)")
            }
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.winePictureImageView.layer.shadowColor = UIColor.CustomColors.shadowColor.cgColor
        self.wineDescriptionStackView.layer.shadowColor = UIColor.CustomColors.shadowColor.cgColor
        self.wineCharacteristicsStackView.layer.shadowColor = UIColor.CustomColors.shadowColor.cgColor
    }
}

extension WineViewController: WineViewInput {
    func fillStars(with rating: Float) {
        let fullStars = Int(rating)
        let halfStar = rating - Float(fullStars)
        
        var starsArray: [UIImage?] = []
        
        for _ in 0..<fullStars {
            let imageView = SystemImage.starFill.image
            starsArray.append(imageView)
        }
        
        if halfStar > 0.5 {
            let imageView = SystemImage.starHalf.image
            starsArray.append(imageView)
        }
        
        let totalStars = fullStars + (halfStar > 0 ? 1 : 0)
        for _ in totalStars..<5 {
            let imageView = SystemImage.star.image
            starsArray.append(imageView)
        }
        
        for (index, star) in starsArray.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4 * Double(index)) {
                let starView = self.wineRatingStarsStackView.arrangedSubviews[index] as? UIImageView
                starView?.image = star
            }
        }
    }
    
    func fillGrapeVarieties(with varieties: [String]) {
        for variety in varieties {
            let label = UILabel()
            label.text = variety
            label.textAlignment = .center
            label.numberOfLines = 0
            label.font = .playfair(ofSize: 14, style: .regular)
            
            self.wineGrapeVarietiesStackView.addArrangedSubview(label)
        }
    }
}

private extension WineViewController {
    func setupUI() {
        self.view.addSubview(
            self.scrollView
        )
        
        self.scrollView.addSubview(
            self.contentView
        )
        
        self.contentView.addSubview(
            self.wineBrandLabel,
            self.wineNameLabel,
            self.winePriceLabel,
            self.wineAlcoholLabel,
            self.wineDetailsContentView,
            self.winePictureImageView,
            self.wineFieldsStackView,
            self.wineDescriptionStackView,
            self.grapesVarietiesLabel,
            self.wineGrapeVarietiesStackView,
            self.characteristicsLabel,
            self.wineCharacteristicsStackView
        )
        
        self.wineCountryFieldsStackView.addArrangedSubviews(
            self.countryLabel,
            self.wineCountryLabel
        )
        
        self.wineRegionFieldsStackView.addArrangedSubviews(
            self.regionLabel,
            self.wineRegionLabel
        )
        
        self.wineCategoryFieldsStackView.addArrangedSubviews(
            self.categoryLabel,
            self.wineCategoryLabel
        )
        
        self.wineFieldsStackView.addArrangedSubviews(
            self.wineCountryFieldsStackView,
            self.wineRegionFieldsStackView,
            self.wineCategoryFieldsStackView
        )
        
        self.wineDescriptionStackView.addArrangedSubviews(
            self.wineRatingStarsStackView,
            self.wineDescriptionLabel
        )
        
        self.wineSweetnessFieldsStackView.addArrangedSubviews(
            self.sweetnessLabel,
            self.wineSweetnessLabel
        )
        
        self.wineBitternessFieldsStackView.addArrangedSubviews(
            self.bitternessLabel,
            self.wineBitternessLabel
        )
        
        self.wineAcidityFieldsStackView.addArrangedSubviews(
            self.acidityLabel,
            self.wineAcidityLabel
        )
        
        self.wineCharacteristicsStackView.addArrangedSubviews(
            self.wineSweetnessFieldsStackView,
            self.wineBitternessFieldsStackView,
            self.wineAcidityFieldsStackView
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
            //            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: 2),
            
            self.wineBrandLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.wineBrandLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30),
            self.wineBrandLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -30),
            
            self.wineNameLabel.topAnchor.constraint(equalTo: self.wineBrandLabel.bottomAnchor, constant: 0),
            self.wineNameLabel.leadingAnchor.constraint(equalTo: self.wineBrandLabel.leadingAnchor),
            self.wineNameLabel.trailingAnchor.constraint(equalTo: self.winePictureImageView.leadingAnchor),
            
            self.winePriceLabel.topAnchor.constraint(equalTo: self.wineNameLabel.bottomAnchor, constant: 20),
            self.winePriceLabel.leadingAnchor.constraint(equalTo: self.wineNameLabel.leadingAnchor),
            self.winePriceLabel.trailingAnchor.constraint(equalTo: self.winePictureImageView.leadingAnchor),
            self.winePriceLabel.heightAnchor.constraint(equalToConstant: 30),
            
            self.wineDetailsContentView.topAnchor.constraint(equalTo: self.winePriceLabel.bottomAnchor, constant: 20),
            self.wineDetailsContentView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 70),
            self.wineDetailsContentView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1.5),
            self.wineDetailsContentView.bottomAnchor.constraint(equalTo: self.wineDescriptionStackView.bottomAnchor, constant: 30),
            
            self.winePictureImageView.topAnchor.constraint(equalTo: self.wineNameLabel.centerYAnchor, constant: 0),
            self.winePictureImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -50),
            self.winePictureImageView.widthAnchor.constraint(equalToConstant: 100),
            self.winePictureImageView.heightAnchor.constraint(equalToConstant: 320),
            
            self.wineAlcoholLabel.topAnchor.constraint(equalTo: self.winePictureImageView.bottomAnchor, constant: 10),
            self.wineAlcoholLabel.centerXAnchor.constraint(equalTo: self.winePictureImageView.centerXAnchor),
            
            self.wineFieldsStackView.topAnchor.constraint(equalTo: self.wineDetailsContentView.topAnchor, constant: 50),
            self.wineFieldsStackView.leadingAnchor.constraint(equalTo: self.wineDetailsContentView.leadingAnchor, constant: 40),
            self.wineFieldsStackView.trailingAnchor.constraint(equalTo: self.winePictureImageView.leadingAnchor, constant: 0),
            self.wineFieldsStackView.bottomAnchor.constraint(equalTo: self.winePictureImageView.bottomAnchor, constant: 0),
            
            self.wineDescriptionStackView.topAnchor.constraint(equalTo: self.wineAlcoholLabel.bottomAnchor, constant: 20),
            self.wineDescriptionStackView.leadingAnchor.constraint(equalTo: self.winePriceLabel.leadingAnchor),
            self.wineDescriptionStackView.trailingAnchor.constraint(equalTo: self.winePictureImageView.leadingAnchor, constant: -10),
            
            self.grapesVarietiesLabel.topAnchor.constraint(equalTo: self.wineDetailsContentView.bottomAnchor, constant: 25),
            self.grapesVarietiesLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            self.wineGrapeVarietiesStackView.topAnchor.constraint(equalTo: self.grapesVarietiesLabel.bottomAnchor, constant: 25),
            self.wineGrapeVarietiesStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.wineGrapeVarietiesStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            
            self.characteristicsLabel.topAnchor.constraint(equalTo: self.wineGrapeVarietiesStackView.bottomAnchor, constant: 25),
            self.characteristicsLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            self.wineCharacteristicsStackView.topAnchor.constraint(equalTo: self.characteristicsLabel.bottomAnchor, constant: 25),
            self.wineCharacteristicsStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.wineCharacteristicsStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            self.wineCharacteristicsStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -20),
        ])
    }
    
}
