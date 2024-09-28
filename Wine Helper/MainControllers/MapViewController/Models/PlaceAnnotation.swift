//
//  PlaceAnnotation.swift
//  Wine Helper
//
//  Created by Евгений Митюля on 4/14/24.
//

import Foundation
import MapKit

class PlaceAnnotation: MKPointAnnotation {
    
    let mapItem: MKMapItem
    let id = UUID()
    var isSelected: Bool = false
    
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
        super.init()
        self.coordinate = mapItem.placemark.coordinate
    }
    
    var name: String {
        self.mapItem.name ?? ""
    }
    
    var phone: String {
        self.mapItem.phoneNumber ?? ""
    }
    
    var address: String {
        "\(self.mapItem.placemark.subThoroughfare ?? "") \(self.mapItem.placemark.thoroughfare ?? "") \(self.mapItem.placemark.locality ?? "")"
    }
    
    var location: CLLocation {
        self.mapItem.placemark.location ?? CLLocation.default
    }
}
