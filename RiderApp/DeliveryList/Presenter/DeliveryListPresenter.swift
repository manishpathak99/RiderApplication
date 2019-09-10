//
//  DeliveryListPresenter.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import Foundation
class DeliveryListPresenter: DeliveryListPresenterProtocol {
    var view: DeliveryListViewProtocol?
    var interactor: DeliveryListInteractorInputProtocol?
    var router: DeliveryListRouterProtocol?
    var reachability: ReachabilityProtocol = NetworkReachability.shared()
    
    func viewDidLoad() {
        retrieveDeliveryList(onLaunch: true, offSet: 0)
    }
    
    func retrieveDeliveryList(onLaunch: Bool, offSet: Int) {
        
        if reachability.isInternetAvailable() {
            if view?.loadingState() ?? false {
                return
            }
            view?.setLoadingState(true)
            if onLaunch {
                view?.showLoading()
            }
            interactor?.retrieveDeliveryList(offSet)
        } else {
            view?.setLoadingState(true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let deliveries = self?.interactor?.retrieveDeliveriesFromDB(offSet), !deliveries.isEmpty else {
                    self?.view?.setLoadingState(false)
                    self?.view?.showNoInternet()
                    return
                }
                self?.view?.show(deliveries: deliveries)
                self?.view?.setLoadingState(false)
            }
        }
    }
    
    func showMap(forDelivery deliveryModel: DeliveryModel) {
        router?.presentMapScreen(from: view!, forDelivery: deliveryModel)
    }
}

extension DeliveryListPresenter: DeliveryListInteractorOutputProtocol {
    
    func didRetrieveDelivery(_ deliveries: [DeliveryModel]) {
        deliveries.isEmpty ? view?.noMoreDataAvailable() : view?.show(deliveries: deliveries)
        view?.setLoadingState(false)
    }
    
    func onError() {
        view?.showError()
        view?.setLoadingState(false)
    }
}
