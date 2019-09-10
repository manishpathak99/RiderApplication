//
//  JsonUtil.swift
//  RiderAppTests
//
//  Created by MANISH PATHAK on 9/8/19.
//
import Foundation
import ObjectMapper
@testable import RiderApp

class JSONUtil {

    class func readJSON(from jsonFileName: String) -> Data? {
        if let path = Bundle.main.path(forResource: jsonFileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                return nil
            }
        }
        return nil
    }

    class func getDeliveries() -> [DeliveryModel] {
        
        do {
            guard let data = readJSON(from: "deliveryList") else {
                return []
            }
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            let deliveries = Mapper<DeliveryModel>().mapArray(JSONObject: json)

            return deliveries!
        } catch {
            
        }
        return []
    }
}
