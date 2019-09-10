//
//  DeliveryListInteractor.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/9/19.
//

import Quick
import Nimble

@testable import RiderApp

class DeliveryListInteractorSpec: QuickSpec {
    var deliveryListInteractor: DeliveryListInteractor?
    
    private func setupModule(){
        let mockLocalDataManager = MockLocalDataManager()
        let mockRemoteDataManager  = MockRemoteDataManager()
        let mockListPresenter = MockListPresenter()
        
        self.deliveryListInteractor = DeliveryListInteractor()
        self.deliveryListInteractor?.localDatamanager = mockLocalDataManager
        self.deliveryListInteractor?.remoteDatamanager = mockRemoteDataManager
        self.deliveryListInteractor?.presenter = mockListPresenter
    }
    
    override func spec() {
        describe("DeliveryListInteractor") {
            context("when app starts fetching the delivery", {
                beforeEach {
                    self.setupModule()
                }
                context("when API call is made") {
                    context("and in case existing api going on") {
                        beforeEach {
                            let remote = self.deliveryListInteractor?.remoteDatamanager as? MockRemoteDataManager
                            remote?.isAPICallInProgress = true
                            self.deliveryListInteractor?.retrieveDeliveryList(0)
                        }
                        
                        it("should not API Call") {
                            let remote = self.deliveryListInteractor?.remoteDatamanager as? MockRemoteDataManager
                            expect(remote?.mock_retrieveDeliveryList_calls).to(equal(0))
                        }
                    }
                    
                    context("and in case there is not previous API call made") {
                        beforeEach {
                            let remote = self.deliveryListInteractor?.remoteDatamanager as? MockRemoteDataManager
                            remote?.isAPICallInProgress = false
                            self.deliveryListInteractor?.retrieveDeliveryList(0)
                        }
                        
                        it("should API call and retrieve delivery list") {
                            let remote = self.deliveryListInteractor?.remoteDatamanager as? MockRemoteDataManager
                            expect(remote?.mock_retrieveDeliveryList_calls).to(equal(1))
                        }
                    }
                    
                    
                    context("and app fetches the data from server") {
                        context("and data is retrieved") {
                            beforeEach {
                                self.deliveryListInteractor?.onRetrieved(deliveries: JSONUtil.getDeliveries())
                            }
                            it("should return the deliveries") {
                                let presenter = self.deliveryListInteractor?.presenter as? MockListPresenter
                                expect(presenter?.mock_didRetrieveDelivery_calls).to(equal(1))
                            }
                        }
                        
                        context("and there is an error occured") {
                            beforeEach {
                                self.deliveryListInteractor?.onError()
                            }
                            it("should check delivery in db and show error if there is no data") {
                                let presenter = self.deliveryListInteractor?.presenter as? MockListPresenter
                                let deliveries = self.deliveryListInteractor?.retrieveDeliveriesFromDB()
                                if deliveries!.isEmpty {
                                    expect(presenter?.mock_onError_calls).to(equal(1))
                                } else {
                                    expect(presenter?.mock_didRetrieveDelivery_calls).to(equal(1))
                                }
                            }
                        }
                    }
                }
                
                context("When app fetches the data from local DB") {
                    context("and data is available ") {
                        var deliveries: [DeliveryModel]?
                        beforeEach {
                            let local = self.deliveryListInteractor?.localDatamanager as? MockLocalDataManager
                            local?.saveDelivery(JSONUtil.getDeliveries())
                            deliveries = self.deliveryListInteractor?.retrieveDeliveriesFromDB(0)
                        }
                        it("should return the deliveries") {
                            let local = self.deliveryListInteractor?.localDatamanager as? MockLocalDataManager
                            expect(local?.mock_retrieveList_calls).to(equal(1))
                            expect(deliveries?.count).to(beGreaterThan(0))
                        }
                    }
                    
                    context("and data is not available ") {
                        var deliveries: [DeliveryModel]?
                        beforeEach {
                            let local = self.deliveryListInteractor?.localDatamanager as? MockLocalDataManager
                            do {
                                try local?.clearAllDelivery()
                            } catch {
                                print("Realm DB Exception")
                            }
                            deliveries = self.deliveryListInteractor?.retrieveDeliveriesFromDB(0)
                        }
                        it("should return no delivery") {
                            let local = self.deliveryListInteractor?.localDatamanager as? MockLocalDataManager
                            expect(local?.mock_retrieveList_calls).to(equal(1))
                            expect(deliveries?.count).to(equal(0))
                        }
                    }
                }
            })
        }
    }
}
