//
//  MockListPresenter.swift
//  RiderAppTests
//
//  Created by MANISH PATHAK on 9/9/19.
//

import RealmSwift

@testable import RiderApp

class MockLocalDataManager :DeliveryListLocalDataManagerInputProtocol {
    
    var mock_retrieveList_calls = 0
    var mock_saveDelivery_calls = 0
    var mock_clearAllDelivery_calls = 0
    
    
    func retrieveList() -> [DeliveryModel]? {
        guard let realm = try? Realm() else {
            return []
        }
        mock_retrieveList_calls += 1
        
        let deliveries: Results<DeliveryModel> = realm.objects(DeliveryModel.self)
        return deliveries.toArray()
    }
    
    func saveDelivery(_ deliveries: [DeliveryModel]) {
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
        
        mock_saveDelivery_calls += 1
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
        
        mock_clearAllDelivery_calls += 1
    }
}
