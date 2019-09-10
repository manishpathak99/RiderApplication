//
//  MockListPresenter.swift
//  RiderAppTests
//
//  Created by MANISH PATHAK on 9/9/19.
//

@testable import RiderApp

class MockRemoteDataManager :DeliveryListRemoteDataManagerInputProtocol {
    var remoteRequestHandler: DeliveryListRemoteDataManagerOutputProtocol?
    var mock_retrieveDeliveryList_calls = 0
    
    var isAPICallInProgress: Bool?
    
    func retrieveDeliveryList(offset: Int, limit: Int) {
        mock_retrieveDeliveryList_calls += 1
    }
}
