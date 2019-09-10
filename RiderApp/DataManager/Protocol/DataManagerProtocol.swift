//
//  DataManagerProtocol.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/9/19.
//

protocol DeliveryListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: DeliveryListRemoteDataManagerOutputProtocol? { get set }
    var isAPICallInProgress: Bool? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrieveDeliveryList(offset: Int, limit: Int)
}

protocol DeliveryListDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol DeliveryListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onRetrieved(deliveries: [DeliveryModel])
    func onError()
}

protocol DeliveryListLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
    func retrieveList() throws -> [DeliveryModel]?
    func saveDelivery(_ deliveries: [DeliveryModel]) throws
    func clearAllDelivery() throws
}
