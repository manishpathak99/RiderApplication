//
//  DeliveryListRouter.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/9/19.
//
//
import Quick
import Nimble

@testable import RiderApp

class DeliveryListRouterSpec: QuickSpec {
    var deliveryListRouter: DeliveryListRouter?
    var deliveries: [DeliveryModel]?
    var mockDeliveryListVC: DeliveryListViewController?
    
    override func spec() {
        describe("DeliveryListRouter") {
            
            context("when screen is navigated from DeliveryList") {
                beforeEach {
                    self.deliveries = JSONUtil.getDeliveries()
                    self.mockDeliveryListVC = DeliveryListViewController.stub(model: self.deliveries!)
                    self.deliveryListRouter = DeliveryListRouter()
                    self.deliveryListRouter?.presentMapScreen(from: self.mockDeliveryListVC!, forDelivery: self.deliveries![0])
                }
                
                it("should present the Map Screen") {
                    expect(self.mockDeliveryListVC?.navigationController?.viewControllers.count).to(equal(1))
                }
            }
        }
    }
}
