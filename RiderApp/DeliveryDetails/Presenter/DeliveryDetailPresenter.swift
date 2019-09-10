//
//  DeliveryDetailPresenter.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import MapKit

class DeliveryDetailPresenter: DeliveryDetailPresenterProtocol {
   
    var view: DeliveryDetailViewProtocol?
    var interactor: DeliveryDetailInteractorInputProtocol?
    var router: DeliveryDetailRouterProtocol?
    
    func viewDidLoad() {
        view?.placeDestinationPin()
    }
    
    func setLocationDetail(_ model: DeliveryModel) {
        view?.setLocationDetail(text: model.getDeliveryText(), imageURL: model.getImageUrl())
    }
}
