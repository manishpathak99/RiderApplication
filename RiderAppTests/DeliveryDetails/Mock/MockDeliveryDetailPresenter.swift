//
//  MockDeliveryListPresenter.swift
//  RiderAppTests
//
//  Created by MANISH PATHAK on 9/10/19.
//

@testable import RiderApp

class MockDeliveryDetailPresenter: DeliveryDetailPresenterProtocol {
    var view: DeliveryDetailViewProtocol?
    var interactor: DeliveryDetailInteractorInputProtocol?
    var router: DeliveryDetailRouterProtocol?
    
    var mock_setLocationDetail_calls = 0
    var mock_viewDidLoad_calls = 0
    
    func viewDidLoad() {
        mock_viewDidLoad_calls += 1
    }
    
    func setLocationDetail(_ model: DeliveryModel) {
        mock_setLocationDetail_calls += 1
    }
}
