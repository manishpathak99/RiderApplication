//
//  MockDeliveryDetailViewController.swift
//  RiderAppTests
//
//  Created by MANISH PATHAK on 9/9/19.
//

import UIKit
@testable import RiderApp

class MockDeliveryDetailViewController: DeliveryDetailViewProtocol {
    var presenter: DeliveryDetailPresenterProtocol?
    
    var mock_setLocationDetail_calls = 0
    var mock_placeDestinationPin_calls = 0
    
    func setLocationDetail(text: String, imageURL: URL?) {
        mock_setLocationDetail_calls += 1
    }
    
    func placeDestinationPin() {
        mock_placeDestinationPin_calls += 1
    }
}

extension DeliveryDetailViewController {
    static func stub(model: DeliveryModel) -> DeliveryDetailViewController {
        let viewController = DeliveryDetailViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        viewController.model = model
        return viewController
    }
}
