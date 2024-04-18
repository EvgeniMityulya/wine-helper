//
//  MainTabBarController.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 3/23/24.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupControllers()
        self.setupUI()
    }
    
    private func setupControllers() {
        let mapViewController = MapViewController()
        let catalogViewController = CatalogBuilder.setupModule()
        let profileViewController = ProfileViewController()
        
        let navMapViewController = mapViewController
        let navCatalogViewController = catalogViewController
        let navProfileViewController = UINavigationController(rootViewController: profileViewController)
        
        self.viewControllers = [
            navMapViewController,
            navCatalogViewController,
            navProfileViewController,
        ]
    }
    
    private func setupUI() {
        
//        let blurEffectStyle: UIBlurEffect.Style
//            if self.traitCollection.userInterfaceStyle == .dark {
//                blurEffectStyle = .prominent
//            } else {
//                blurEffectStyle = .dark
//            }

        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tabBar.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tabBar.insertSubview(blurView, at: 0)
        
//        let appereance = UITabBarAppearance()
//        appereance.configureWithDefaultBackground()
//        appereance.backgroundColor = UIColor.black
//        self.tabBar.isTranslucent = true
//        self.tabBar.standardAppearance = appereance
//        self.tabBar.scrollEdgeAppearance = appereance
        
        self.tabBar.tintColor = UIColor.CustomColors.buttonWhite
        self.tabBar.unselectedItemTintColor = UIColor.CustomColors.burgundy
        
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        tabBar.items?.forEach { item in
            item.setTitleTextAttributes(attributes, for: .selected)
            item.setTitleTextAttributes(attributes, for: .normal)
        }
        
        self.tabBar.items?[0].image = SystemImage.location.image
        self.tabBar.items?[0].title = "Map"
        
        self.tabBar.items?[1].image = UIImage(named: "wineglass")?
                                        .withRenderingMode(.alwaysOriginal)
                                        .resized(to: CGSize(width: 28, height: 28)
                                        )
        self.tabBar.items?[1].title = "Catalog"
        
        self.tabBar.items?[2].image = SystemImage.person.image
        self.tabBar.items?[2].title = "Profile"
    }
}
