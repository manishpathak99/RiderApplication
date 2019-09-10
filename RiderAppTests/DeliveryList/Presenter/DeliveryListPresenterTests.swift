//
//  DeliveryListPresenter.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/9/19.
//

import Quick
import Nimble

@testable import RiderApp

class DeliveryListPresenterSpec: QuickSpec {
    
    var deliveryListPresenter: DeliveryListPresenter?
    
    var view: DeliveryListViewProtocol?
    var interactor: DeliveryListInteractorInputProtocol?
    var router: DeliveryListRouterProtocol?
    
    private func setupModule(){
        let mockView = MockDeliveryListViewController()
        mockView.presenter = self.deliveryListPresenter
        let mockDeliveryListInteractor  = MockDeliveryListInteractor()
        let mockDeliveryListRouter = MockDeliveryListRouter()
        
        self.deliveryListPresenter = DeliveryListPresenter()
        self.deliveryListPresenter?.view = mockView
        self.deliveryListPresenter?.interactor = mockDeliveryListInteractor
        self.deliveryListPresenter?.router = mockDeliveryListRouter
    }
    
    override func spec() {
        describe("DeliveryListPresenter") {
            context("when application loads first time", {
                beforeEach {
                    self.setupModule()
                }
                context("and when internet is available") {
                    context("and when view didload methods call ") {
                        beforeEach {
                            self.deliveryListPresenter?.reachability = MockReachability(mockAvailablity: true)
                            self.deliveryListPresenter?.viewDidLoad()
                        }
                        
                        it("it should fetch the data and show on the listview") {
                            let mockView = self.deliveryListPresenter?.interactor as? MockDeliveryListInteractor
                            expect(mockView?.mock_retrieveDeliveryList_calls).to(equal(1))
                        }
                    }
                    
                    context("when start fetching the deliveries") {
                        beforeEach {
                            self.deliveryListPresenter?.reachability = MockReachability(mockAvailablity: true)
                            self.deliveryListPresenter?.retrieveDeliveryList(onLaunch: false, offSet: 0)
                        }
                        
                        it("should API call and retrive delivery list") {
                            let mockView = self.deliveryListPresenter?.interactor as? MockDeliveryListInteractor
                            expect(mockView?.mock_retrieveDeliveryList_calls).toEventually(equal(1), timeout: 2)
                            
                            expect(mockView?.mock_retrieveDeliveryList_calls).to(equal(1))
                        }
                    }
                }
                
                context("and when internet is not available") {
                    context("and when view didload methods call ") {
                        beforeEach {
                            self.deliveryListPresenter?.reachability = MockReachability(mockAvailablity: false)
                            self.deliveryListPresenter?.viewDidLoad()
                        }
                        
                        it("it should fetch the data and show on the listview") {
                            let mockView = self.deliveryListPresenter?.interactor as? MockDeliveryListInteractor
                            expect(mockView?.mock_retrieveDeliveriesFromDB_calls).toEventually(equal(1), timeout: 2)
                        }
                    }
                    
                    context("when start fetching the deliveries") {
                        beforeEach {
                            self.deliveryListPresenter?.reachability = MockReachability(mockAvailablity: false)
                            self.deliveryListPresenter?.retrieveDeliveryList(onLaunch: false, offSet: 0)
                        }
                        
                        it("should retrive delivery list from database") {
                            let mockView = self.deliveryListPresenter?.interactor as? MockDeliveryListInteractor
                            expect(mockView?.mock_retrieveDeliveriesFromDB_calls).toEventually(equal(1), timeout: 2)
                        }
                    }
                }
                
                context("when there is an error occured") {
                    beforeEach {
                        self.deliveryListPresenter?.interactor?.presenter?.onError()
                    }
                    
                    it("should show error alert") {
                        let mockView = self.deliveryListPresenter?.view as? MockDeliveryListViewController
                        expect(mockView?.mock_showErrors_calls).to(equal(0))
                    }
                }
                
                context("when user navigates to Map screen") {
                    beforeEach {
                        self.deliveryListPresenter?.showMap(forDelivery: MockDeliveryModel.create())
                    }
                    
                    it("should show the map screen") {
                        let mockView = self.deliveryListPresenter?.router as? MockDeliveryListRouter
                        expect(mockView?.mock_presentMapScreen_calls).to(equal(1))
                    }
                }
            })
        }
    }
}

class MockDeliveryListInteractor: DeliveryListInteractorInputProtocol {
    
    var presenter: DeliveryListInteractorOutputProtocol?
    var localDatamanager: DeliveryListLocalDataManagerInputProtocol?
    var remoteDatamanager: DeliveryListRemoteDataManagerInputProtocol?
    
    var mock_retrieveDeliveryList_calls = 0
    var mock_retrieveDeliveriesFromDB_calls = 0
    func retrieveDeliveryList(_ fromOffset: Int) {
        mock_retrieveDeliveryList_calls += 1
    }
    
    func retrieveDeliveriesFromDB(_ fromOffset: Int) -> [DeliveryModel] {
        let deliveries = JSONUtil.getDeliveries()
        mock_retrieveDeliveriesFromDB_calls += 1
        return deliveries
    }
    
}

class MockDeliveryListRouter: DeliveryListRouterProtocol {
    var mock_presentMapScreen_calls = 0
    
    static func make() -> UIViewController {
        return UIViewController()
    }
    
    func presentMapScreen(from view: DeliveryListViewProtocol, forDelivery delivery: DeliveryModel) {
        mock_presentMapScreen_calls += 1
    }
}

class MockDeliveryModel {
    class func create() -> DeliveryModel{
        let model = DeliveryModel.init()
        model.mId = 1
        model.imageUrl = "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-0.jpeg"
        model.descriptions = "Deliver documents to Andrio"
        let location = LocationModel()
        location.latitude = 22.319181
        location.longitude = 114.170008
        location.address = "Mong Kok"
        model.location = location
        return model
    }
}
