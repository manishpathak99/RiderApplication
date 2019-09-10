//
//  MockDeliveryListPresenter.swift
//  RiderAppTests
//
//  Created by MANISH PATHAK on 9/9/19.
//

@testable import RiderApp

class MockDeliveryListPresenter: DeliveryListPresenterProtocol {
    var view: DeliveryListViewProtocol?
    var interactor: DeliveryListInteractorInputProtocol?
    var router: DeliveryListRouterProtocol?
    
    var mock_viewDidLoad_calls = 0
    var mock_retrieveDeliveryList_calls = 0
    var mock_showMap_calls = 0
    
    func viewDidLoad() {
        mock_viewDidLoad_calls += 1
    }
    
    func retrieveDeliveryList(onLaunch: Bool, offSet: Int) {
        mock_retrieveDeliveryList_calls += 1
        
    }
    
    func showMap(forDelivery deliveryModel: DeliveryModel) {
        mock_showMap_calls += 1
    }
}
