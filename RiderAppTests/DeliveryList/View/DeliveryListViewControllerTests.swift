//
//  DeliveryListViewController.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/9/19.
//

import UIKit
import Quick
import Nimble

@testable import RiderApp

class DeliveryListViewControllerSpec: QuickSpec {
    var deliveryListVC: DeliveryListViewController?

    private func setupModule(){
        self.deliveryListVC = DeliveryListViewController.stub(model: JSONUtil.getDeliveries())
        
        let mockPresenter = MockDeliveryListPresenter()
        deliveryListVC?.presenter = mockPresenter
    }
    
    override func spec() {
        describe("DeliveryListViewController") {
            context("when view is loaded", {
                beforeEach {
                    self.setupModule()
                }
                
                context("and when view didload methods call ") {
                    beforeEach {
                        self.deliveryListVC?.viewDidLoad()
                    }
                    it("it should fetch the data and show on the listview") {
                        let mockPresenter = self.deliveryListVC?.presenter as? MockDeliveryListPresenter
                        expect(mockPresenter?.mock_viewDidLoad_calls).to(equal(1))
                    }
                }
                
                context("and when loadView is called") {
                    beforeEach {
                        self.deliveryListVC?.loadView()
                    }
                    
                    it("should add tableview in view") {
                        expect(self.deliveryListVC?.tableView).notTo(beNil())
                    }
                }
                
                context("and when making api call first time and it returns response") {
                    beforeEach {
                        self.deliveryListVC?.handlePullToRefresh(UIView())
                    }
                    
                    it("should show deliveries in tableview") {
                        expect(self.deliveryListVC?.loadingState()).toEventually(beFalse(), timeout: 7)
                        self.deliveryListVC?.loadView()
                        expect(self.deliveryListVC?.tableView?.numberOfRows(inSection: 0) ?? 0 > 0).toEventually(beTrue(), timeout: 7)
                        expect(self.deliveryListVC?.loadingState()).toEventually(beFalse(), timeout: 7)
                    }
                    context("and when user select delivery on tableview") {
                        beforeEach {
                            self.deliveryListVC?.loadView()
                            self.deliveryListVC?.tableView(self.deliveryListVC!.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                        }
                        
                        it("should navigate to map screen") {
                            let presenter = self.deliveryListVC?.presenter as! MockDeliveryListPresenter
                            expect(presenter.mock_showMap_calls).to(equal(1))
                        }
                    }
                }
                
                context("and when List scrolled to bottom") {
                    beforeEach {
                        self.deliveryListVC?.loadView()
                        self.deliveryListVC?.isLoading = false
                        self.deliveryListVC?.tableView(self.deliveryListVC!.tableView, willDisplay: UITableViewCell(), forRowAt: IndexPath(row: 9, section: 0))
                    }
                    
                    it("it should show the bottom loader") {
                        expect(self.deliveryListVC?.tableView.tableFooterView).notTo(beNil())
                    }
                }
                
                context("and when bottom loader is showing") {
                    beforeEach {
                        self.deliveryListVC?.loadView()
                        self.deliveryListVC?.showBottomLoader()
                    }
                    
                    it("it should attach to view") {
                        expect(self.deliveryListVC?.tableView.tableFooterView).notTo(beNil())
                    }
                }
                
                context("and when loader is showing") {
                    var count = 0
                    beforeEach {
                        count = self.deliveryListVC?.view.subviews.count ?? 0
                        self.deliveryListVC?.showLoading()
                    }
                    
                    it("it should attach to view and increased the count by 1") {
                        expect(self.deliveryListVC?.view.subviews.count).to(equal(count + 1))
                    }
                }
                
                context("and when Deliveries are fetched and ready to show") {
                    beforeEach {
                        self.deliveryListVC?.loadView()
                        self.deliveryListVC?.show(deliveries: JSONUtil.getDeliveries())
                    }
                    
                    it("it should show deliveries in tableView") {
                         expect(self.deliveryListVC?.tableView?.numberOfRows(inSection: 0) ?? 0 > 0).toEventually(beTrue(), timeout: 5)
                        expect(self.deliveryListVC?.loadingState()).toEventually(beFalse(), timeout: 5)
                    }
                }
                
                context("and when there is an error") {
                    beforeEach {
                        self.deliveryListVC?.showError()
                    }
                    
                    it("should show error alert") {
                        expect(self.deliveryListVC?.presentedViewController?.isKind(of: UIAlertController.self)).toEventually(beTrue(), timeout: 5)
                    }
                }

                context("and when there is no Internet") {
                    beforeEach {
                        self.deliveryListVC?.showNoInternet()
                    }
                    
                    it("should show noInternet alert") {
                        expect(self.deliveryListVC?.presentedViewController?.isKind(of: UIAlertController.self)).toEventually(beTrue(), timeout: 5)
                    }
                }
                context("and when there is no More Data") {
                    beforeEach {
                        self.deliveryListVC?.noMoreDataAvailable()
                    }
                    
                    it("should show alert") {
                        expect(self.deliveryListVC?.presentedViewController?.isKind(of: UIAlertController.self)).toEventually(beTrue(), timeout: 5)
                    }
                }
                
            })
        }
    }
}

extension DeliveryListViewController {
    static func stub(model: [DeliveryModel]) -> DeliveryListViewController {
        let viewController = DeliveryListViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        viewController.deliveries = model
        return viewController
    }
}
