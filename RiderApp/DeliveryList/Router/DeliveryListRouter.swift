//
//  DeliveryListRouter.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import UIKit

class DeliveryListRouter: DeliveryListRouterProtocol {
    
    class func make() -> UIViewController {
        let rootControoler = DeliveryListViewController()
        let navigationController = UINavigationController(rootViewController: rootControoler)
        if let view = navigationController.children.first as? DeliveryListViewController {
            let presenter: DeliveryListPresenterProtocol & DeliveryListInteractorOutputProtocol = DeliveryListPresenter()
            let interactor: DeliveryListInteractorInputProtocol & DeliveryListRemoteDataManagerOutputProtocol = DeliveryListInteractor()
            let localDataManager: DeliveryListLocalDataManagerInputProtocol = DeliveryListLocalDataManager()
            let remoteDataManager: DeliveryListRemoteDataManagerInputProtocol = DeliveryListRemoteDataManager()
            let router: DeliveryListRouterProtocol = DeliveryListRouter()
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            return navigationController
        }
        return UIViewController()
    }
    
    func presentMapScreen(from view: DeliveryListViewProtocol, forDelivery delivery: DeliveryModel) {
        let mapVC = DeliveryDetailRouter.make(forDelivery: delivery)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(mapVC, animated: true)
        }
    }
}
