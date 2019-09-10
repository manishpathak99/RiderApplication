//
//  DeliveryListLocalDataManager.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/9/19.
//

import RealmSwift

class DeliveryListLocalDataManager: DeliveryListLocalDataManagerInputProtocol {
    
    func retrieveList() throws -> [DeliveryModel]? {
        guard let realm = try? Realm() else {
            return []
        }
        let deliveries: Results<DeliveryModel> = realm.objects(DeliveryModel.self)
        return deliveries.toArray()
    }
    
    func saveDelivery(_ deliveries: [DeliveryModel]) throws {
        guard let realm = try? Realm() else {
            return
        }
        do {
            try realm.write {
                for delivery in deliveries {
                    realm.add(delivery, update: .all)
                }
            }
        } catch _ as NSError {
            print("Realm Excpetion")
        }
    }
    
    func clearAllDelivery() throws {
        guard let realm = try? Realm() else {
            return
        }
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch _ as NSError {
            print("Realm Excpetion")
        }
    }
}
