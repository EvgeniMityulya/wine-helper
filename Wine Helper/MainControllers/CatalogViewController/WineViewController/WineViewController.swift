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
        description: "An elegant wine with aromas of blackcurrant, cherry and oak, with soft tannins and a long aftertaste.",
        alcoholPl: 13.5,
        sweetness: 2,
        bitterness: 3,
        acidity: 4,
        country: "France",
        region: "Bordeaux",
        grapeSort: ["Cabernet Sauvignon", "Merlot", "Petit Verdot"],
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
        scrollView.backgroundColor = .white
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
        imageView.layer.shadowColor = UIColor.black.cgColor
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
        label.text = wineModel.brand
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(ofSize: 18, style: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var wineNameLabel: UILabel = {
        let label = UILabel()
        label.text = wineModel.name
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .openSans(ofSize: 20, style: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.CustomColors.background
        self.setupUI()
    }
    
}

extension WineViewController: WineViewInput {
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
            self.winePictureImageView
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
            self.contentView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor),
            
            self.wineBrandLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.wineBrandLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            self.wineBrandLabel.trailingAnchor.constraint(equalTo: self.winePictureImageView.leadingAnchor),
            
            self.wineNameLabel.topAnchor.constraint(equalTo: self.wineBrandLabel.bottomAnchor, constant: 5),
            self.wineNameLabel.leadingAnchor.constraint(equalTo: self.wineBrandLabel.leadingAnchor),
            self.wineNameLabel.trailingAnchor.constraint(equalTo: self.winePictureImageView.leadingAnchor),
            
            self.winePictureImageView.topAnchor.constraint(equalTo: self.wineBrandLabel.bottomAnchor, constant: 0),
            self.winePictureImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -50),
            self.winePictureImageView.widthAnchor.constraint(equalToConstant: 100),
            self.winePictureImageView.heightAnchor.constraint(equalToConstant: 300),
        ])
    }
    
}
