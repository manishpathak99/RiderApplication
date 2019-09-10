//
//  CustomAnnotation.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import UIKit
import MapKit

class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(title: String = Localization.currentLocation, location: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = location
    }
}
