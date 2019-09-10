//
//  MockRemoteOutputDataManager.swift
//  RiderAppTests
//
//  Created by MANISH PATHAK on 9/9/19.
//

@testable import RiderApp

class MockRemoteOutputDataManager :DeliveryListRemoteDataManagerOutputProtocol {
    var mock_onRetrieved_calls = 0
    var mock_onError_calls = 0
    
    func onRetrieved(deliveries: [DeliveryModel]) {
        mock_onRetrieved_calls += 1
    }
    
    func onError() {
        mock_onError_calls += 1
    }
}
