//
//  DeliveryDetailViewController.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/9/19.
//

import UIKit
import Quick
import Nimble

@testable import RiderApp

class DeliveryDetailViewControllerSpec: QuickSpec {
    var deliveryDetailVC: DeliveryDetailViewController?
    
    private func setupModule(){
        self.deliveryDetailVC = DeliveryDetailViewController.stub(model: JSONUtil.getDeliveries()[0])
        
        let mockPresenter = MockDeliveryDetailPresenter()
        deliveryDetailVC?.presenter = mockPresenter
    }
    
    override func spec() {
        describe("DeliveryDetailViewController") {
            context("when view is loaded", {
                beforeEach {
                    self.setupModule()
                }
                
                context("and when view didload methods call ") {
                    beforeEach {
                        self.deliveryDetailVC?.viewDidLoad()
                    }
                    it("it should setup the UI") {
                        let mockPresenter = self.deliveryDetailVC?.presenter as? MockDeliveryDetailPresenter
                        expect(mockPresenter?.mock_viewDidLoad_calls).to(equal(2))
                        expect(self.deliveryDetailVC?.view.subviews.count).to(equal(6))
                    }
                    
                    context("and when destination pin is added ") {
                        beforeEach {
                            self.deliveryDetailVC?.placeDestinationPin()
                        }
                        it("and it should place the PIN on View") { expect(self.deliveryDetailVC?.mapView.annotations.count).to(equal(1))
                        }
                    }
                    
                    context("and when details are added in view") {
                        beforeEach {
                            self.deliveryDetailVC?.setLocationDetail(text: "Deliver food to Eric", imageURL: URL(string: "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-7.jpeg"))
                        }
                        it("and it should show the delivery text") {
                            expect(self.deliveryDetailVC?.destinationLabel.text == "Deliver food to Eric").to(equal(true))
                            let mockPresenter = self.deliveryDetailVC?.presenter as? MockDeliveryDetailPresenter
                            expect(mockPresenter?.mock_setLocationDetail_calls).to(equal(2))
                        }
                    }
                }
            })
        }
    }
}
