//
//  DeliveryListInteractor.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import RealmSwift

class DeliveryListInteractor: DeliveryListInteractorInputProtocol {
    var presenter: DeliveryListInteractorOutputProtocol?
    var localDatamanager: DeliveryListLocalDataManagerInputProtocol?
    var remoteDatamanager: DeliveryListRemoteDataManagerInputProtocol?
    var offset = 0
    
    func retrieveDeliveriesFromDB(_ fromOffset: Int = 0) -> [DeliveryModel] {
        offset = fromOffset
        do {
            if let deliveries = try localDatamanager?.retrieveList(), !deliveries.isEmpty {
                if fromOffset > deliveries.count {
                    return []
                }
                var endIndex = fromOffset + Constants.AppAPI.limit - 1
                if endIndex > deliveries.count {
                    endIndex = deliveries.count - 1
                }
                let startIndex = endIndex - Constants.AppAPI.limit < 0 ? 0 : endIndex - Constants.AppAPI.limit + 1
                return Array(deliveries[startIndex...endIndex])
            }
        } catch {
            return []
        }
        return []
    }
    
    func retrieveDeliveryList(_ fromOffset: Int) {
        if remoteDatamanager?.isAPICallInProgress ?? false {
            return
        }
        remoteDatamanager?.retrieveDeliveryList(offset: fromOffset, limit: Constants.AppAPI.limit)
    }
}

extension DeliveryListInteractor: DeliveryListRemoteDataManagerOutputProtocol {
    
    func onRetrieved(deliveries: [DeliveryModel]) {
        presenter?.didRetrieveDelivery(deliveries)
        do {
            try localDatamanager?.saveDelivery(deliveries)
        } catch {
            presenter?.didRetrieveDelivery([])
        }
    }
    
    func onError() {
        let deliveries = retrieveDeliveriesFromDB(offset)
        deliveries.isEmpty ? presenter?.onError() : presenter?.didRetrieveDelivery(deliveries)
    }
}
