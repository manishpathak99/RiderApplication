//
//  DeliveryDetailsProtocol.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import UIKit
import CoreLocation
import MapKit

protocol DeliveryDetailViewProtocol: class {
    var presenter: DeliveryDetailPresenterProtocol? { get set }
    
    func setLocationDetail(text: String, imageURL: URL?)
    func placeDestinationPin()
}

protocol DeliveryDetailRouterProtocol: class {
    static func make(forDelivery: DeliveryModel) -> UIViewController
}

protocol DeliveryDetailPresenterProtocol: class {
    var view: DeliveryDetailViewProtocol? { get set }
    var interactor: DeliveryDetailInteractorInputProtocol? { get set }
    var router: DeliveryDetailRouterProtocol? { get set }

    func viewDidLoad()
    func setLocationDetail(_ model: DeliveryModel)
}

protocol DeliveryDetailInteractorInputProtocol: class {
    // empty declaration 
}
