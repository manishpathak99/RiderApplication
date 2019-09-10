//
//  MockListPresenter.swift
//  RiderAppTests
//
//  Created by MANISH PATHAK on 9/9/19.
//

@testable import RiderApp

class MockListPresenter :DeliveryListInteractorOutputProtocol {
    var mock_didRetrieveDelivery_calls = 0
    var mock_onError_calls = 0
    
    func onError() {
        mock_onError_calls += 1
    }
    
    func didRetrieveDelivery(_ deliveries: [DeliveryModel]) {
        mock_didRetrieveDelivery_calls += 1
    }
    
}
