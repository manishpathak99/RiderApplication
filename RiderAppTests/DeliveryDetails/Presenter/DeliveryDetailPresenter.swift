//
//  DeliveryDetailPresenter.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/9/19.
//

import UIKit
import Quick
import Nimble

@testable import RiderApp

class DeliveryDetailPresenterSpec: QuickSpec {
    
    var deliveryDetailPresenter: DeliveryDetailPresenter?
    
    var view: DeliveryListViewProtocol?
    var interactor: DeliveryListInteractorInputProtocol?
    var router: DeliveryListRouterProtocol?
    
    private func setupModule(){
        let mockView = MockDeliveryDetailViewController()
        mockView.presenter = self.deliveryDetailPresenter
        let mockDeliveryDetailInteractor  = MockDeliveryDetailInteractor()
        let mockDeliveryDetailRouter = MockDeliveryDetailRouter()
        
        self.deliveryDetailPresenter = DeliveryDetailPresenter()
        self.deliveryDetailPresenter?.view = mockView
        self.deliveryDetailPresenter?.interactor = mockDeliveryDetailInteractor
        self.deliveryDetailPresenter?.router = mockDeliveryDetailRouter
    }
    
    override func spec() {
        describe("DeliveryDetailPresenter") {
            context("when application loads first time", {
                beforeEach {
                    self.setupModule()
                }
                
                context("and when view didload methods call ") {
                    beforeEach {
                        self.deliveryDetailPresenter?.viewDidLoad()
                    }
                    
                    it("it should place destination pin") {
                        let mockView = self.deliveryDetailPresenter?.view as? MockDeliveryDetailViewController
                        expect(mockView?.mock_placeDestinationPin_calls).to(equal(1))
                    }
                }
                
                context("and when details are added in MapVIew ") {
                    beforeEach {
                        self.deliveryDetailPresenter?.setLocationDetail(MockDeliveryModel.create())
                    }
                    
                    it("it should place destination pin") {
                        let mockView = self.deliveryDetailPresenter?.view as? MockDeliveryDetailViewController
                        expect(mockView?.mock_setLocationDetail_calls).to(equal(1))
                    }
                }
            })
        }
    }
}


class MockDeliveryDetailRouter: DeliveryDetailRouterProtocol {
    static func make(forDelivery: DeliveryModel) -> UIViewController {
        return UIViewController()
    }
}
