//
//  Constants.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import UIKit

class Constants {
    
    struct AppUI {
        struct Indicator {
            static let x = 0
            static let y = 0
            static let width = 80
            static let height = 80
            static let color: UIColor = .gray
        }
        
        struct DeliveryCell {
            static let borderWidth: CGFloat = 1.0
            static let borderColor = UIColor.lightGray.cgColor
            static let numberOfLines = 0
            
            static let imgHeight = 80
            static let imgWidth = 80
            static let imgLeading = 10
            static let imgTop = 10
            static let imgBottom = 10
          
            static let labelTrailing = 10
            static let labelLeading = 10
            static let labelTop = 5
            static let labelBottom = 5
        }
        
        struct MapView {
            static let routeVisibilityArea: Double = 3000
            static let routeLineWidth: CGFloat = 5.0
            static let markerIdentifier = "marker"
            static let routeColor: UIColor = .blue
        }
    }
    
    struct REALM {
        static let PRIMARY_KEY_ID   = "mId"
        static let DEFAULT_INT      = 0
        static let DEFAULT_STRING   = ""
        static let DEFAULT_DOUBLE   = 0.0
    }
    
    struct AppAPI {
        static let baseUrl = "https://mock-api-mobile.dev.lalamove.com"
        static let limit = 10
    }
}
