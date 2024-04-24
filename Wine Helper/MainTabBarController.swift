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
        self.selectedIndex = 1
        self.delegate = self
        navigationItem.leftBarButtonItem?.tintColor = UIColor.CustomColors.burgundy
        navigationItem.backBarButtonItem?.tintColor = UIColor.CustomColors.burgundy
    }
    
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.3, 0.9, 1.0]
        bounceAnimation.duration = TimeInterval(0.3)
        bounceAnimation.calculationMode = CAAnimationCalculationMode.cubic
        return bounceAnimation
    }()
    
    private func setupControllers() {
        let mapViewController = MapBuilder.setupModule()
        let promotionViewController = PromotionBuilder.setupModule()
        let catalogViewController = CatalogBuilder.setupModule()
        let profileViewController = ProfileViewController()
        
        let navMapViewController = mapViewController
        let navPromotionViewController = promotionViewController
        let navCatalogViewController = catalogViewController
        let navProfileViewController = UINavigationController(rootViewController: profileViewController)
        
        self.viewControllers = [
            navMapViewController,
            navPromotionViewController,
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
        
        self.tabBar.tintColor = UIColor.CustomColors.burgundy
        self.tabBar.unselectedItemTintColor = UIColor.CustomColors.shadowColor
        
        
        
        let iconBarSize: CGFloat = 33
        let inset = (tabBar.frame.height - iconBarSize) / 2
        if let items = tabBar.items {
            for item in items {
                item.imageInsets = UIEdgeInsets(top: inset, left: 0, bottom: -inset, right: 0)
            }
        }
        
        self.tabBar.items?[0].image = SystemImage.location.image?
            .withRenderingMode(
                .alwaysOriginal
            )
            .resized(
                to: CGSize(
                    width: iconBarSize,
                    height: iconBarSize
                )
            )
        
        self.tabBar.items?[1].image = UIImage(
            named: SystemImage.wineglass.rawValue
        )?
            .withRenderingMode(
                .alwaysOriginal
            )
            .resized(
                to: CGSize(
                    width: iconBarSize,
                    height: iconBarSize
                )
            )
        
        self.tabBar.items?[2].image = SystemImage.magnifyglass.image?
            .withRenderingMode(
                .alwaysOriginal
            )
            .resized(
                to: CGSize(
                    width: iconBarSize,
                    height: iconBarSize
                )
            )
        
        self.tabBar.items?[3].image = SystemImage.person.image?
            .withRenderingMode(
                .alwaysOriginal
            ).resized(
                to: CGSize(
                    width: iconBarSize,
                    height: iconBarSize
                )
            )
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.firstIndex(of: item),
              tabBar.subviews.count > idx + 1,
              let imageView = tabBar.subviews[idx + 2].subviews.compactMap({ $0 as? UIImageView }).first else {
            return
        }
        imageView.layer.add(bounceAnimation, forKey: nil)
    }
}
