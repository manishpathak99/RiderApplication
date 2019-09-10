//
//  DeliveryDetailRouter.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import UIKit

class DeliveryDetailRouter: DeliveryDetailRouterProtocol {
    
    class func make(forDelivery: DeliveryModel) -> UIViewController {
        let mapController = DeliveryDetailViewController()
        mapController.model = forDelivery
        let presenter: DeliveryDetailPresenterProtocol = DeliveryDetailPresenter()
        let interactor: DeliveryDetailInteractorInputProtocol = DeliveryDetailInteractor()
        let router: DeliveryDetailRouterProtocol = DeliveryDetailRouter()
        mapController.presenter = presenter
        presenter.view = mapController
        presenter.router = router
        presenter.interactor = interactor
        return mapController
    }
}
