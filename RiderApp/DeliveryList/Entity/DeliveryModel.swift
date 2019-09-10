//
//  DeliveryModel.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import Foundation
import ObjectMapper
import RealmSwift

class DeliveryModel: Object, Mappable {
    @objc dynamic var mId = Constants.REALM.DEFAULT_INT
    @objc dynamic var descriptions = Constants.REALM.DEFAULT_STRING
    @objc dynamic var imageUrl = Constants.REALM.DEFAULT_STRING
    @objc dynamic var location: LocationModel?
    
    override static func primaryKey() -> String? {
        return Constants.REALM.PRIMARY_KEY_ID
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        mId              <- map["id"]
        descriptions     <- map["description"]
        imageUrl        <- map["imageUrl"]
        location        <- map["location"]
    }
    
    func getDeliveryText() -> String {
        guard let address = location?.address else {
            return ""
        }
        return String(format: "%@ at %@", descriptions, address)
    }
    
    func getImageUrl() -> URL? {
        return URL(string: imageUrl)
    }
}

class LocationModel: Object, Mappable {
    @objc dynamic var latitude = Constants.REALM.DEFAULT_DOUBLE
    @objc dynamic var longitude = Constants.REALM.DEFAULT_DOUBLE
    @objc dynamic var address = Constants.REALM.DEFAULT_STRING
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        latitude        <- map["lat"]
        longitude       <- map["lng"]
        address         <- map["address"]
    }
}
