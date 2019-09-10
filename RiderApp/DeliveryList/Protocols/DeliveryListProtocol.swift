//
//  DeliveryListProtocol.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import UIKit

protocol DeliveryListViewProtocol: class {
    var presenter: DeliveryListPresenterProtocol? { get set }

    // PRESENTER -> VIEW
    func show(deliveries: [DeliveryModel])
    func showError()
    func showLoading()
    func hideLoading()
    func showNoInternet()
    func loadingState() -> Bool!
    func setLoadingState(_ loading: Bool)
    func noMoreDataAvailable()
}

protocol DeliveryListRouterProtocol: class {
    static func make() -> UIViewController
    // PRESENTER -> ROUTER
    func presentMapScreen(from view: DeliveryListViewProtocol, forDelivery delivery: DeliveryModel)
}

protocol DeliveryListPresenterProtocol: class {
    var view: DeliveryListViewProtocol? { get set }
    var interactor: DeliveryListInteractorInputProtocol? { get set }
    var router: DeliveryListRouterProtocol? { get set }

    // VIEW -> PRESENTER
    func viewDidLoad()
    func retrieveDeliveryList(onLaunch: Bool, offSet: Int)
    func showMap(forDelivery deliveryModel: DeliveryModel)
}

protocol DeliveryListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveDelivery(_ deliveries: [DeliveryModel])
    func onError()
}

protocol DeliveryListInteractorInputProtocol: class {
    var presenter: DeliveryListInteractorOutputProtocol? { get set }
    var localDatamanager: DeliveryListLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: DeliveryListRemoteDataManagerInputProtocol? { get set }

    // PRESENTER -> INTERACTOR
    func retrieveDeliveryList(_ fromOffset: Int)
    func retrieveDeliveriesFromDB(_ fromOffset: Int) -> [DeliveryModel]
}
