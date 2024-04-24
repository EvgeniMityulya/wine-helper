//
//  FilterViewController.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/24/24.
//

import UIKit

protocol FilterInput: AnyObject {
    
}

final class FilterViewController: UIViewController {
    
    var output: FilterViewOutput?
}

extension FilterViewController: CatalogInput {
    
}
