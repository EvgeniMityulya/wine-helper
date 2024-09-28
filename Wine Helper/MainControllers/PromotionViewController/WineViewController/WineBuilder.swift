//
//  WineBuilder.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/13/24.
//

import Foundation
import UIKit

enum WineBuilder {
    static func setupModule(with id: Int, image: UIImage) -> WineViewController {
        let viewController = WineViewController(id: id, image: image)
        let router = WineRouter(viewController: viewController)
        let presenter = WinePresenter(input: viewController, router: router)
        viewController.output = presenter
        return viewController
    }
}
