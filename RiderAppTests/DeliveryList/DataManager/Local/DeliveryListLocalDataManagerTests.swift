//
//  DeliveryListLocalDataManager.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/9/19.
//

//import RealmSwift
import Quick
import Nimble

@testable import RiderApp

class DeliveryListLocalDataManagerSpec: QuickSpec {
    var deliveryListLocalDataManager: DeliveryListLocalDataManagerInputProtocol?
    var deliveryData: [DeliveryModel?] = []
    
    private func setupModule(){
        self.deliveryListLocalDataManager = DeliveryListLocalDataManager()
    }
    
    override func spec() {
        describe("DeliveryListLocalDataManager") {
            beforeEach {
                self.setupModule()
            }
            
            context("when data is available in the storage", {
                beforeEach {
                    self.saveData()
                    do {
                        if let deliveries = try self.deliveryListLocalDataManager?.retrieveList() {
                            self.deliveryData = deliveries
                        } else {
                            self.deliveryData = []
                        }
                    }
                    catch {
                        self.deliveryData = []
                    }
                }
                
                it("should return the delivery data") {
                    expect(self.deliveryData.count > 0).to(equal(true))
                }
            })
            
            context("when data is not available in the storage", {
                beforeEach {
                    self.clearData()
                    do {
                        if let deliveries = try self.deliveryListLocalDataManager?.retrieveList(){
                            self.deliveryData = deliveries
                        } else {
                            self.deliveryData = []
                        }
                    }
                    catch {
                        self.deliveryData = []
                    }
                }
                it("should return empty array") {
                    expect(self.deliveryData.count == 0).to(equal(true))
                }
            })
            
            context("save data to storage ", {
                beforeEach {
                    self.saveData()
                }
                it("should save data" ) {
                    do {
                        if let deliveries = try self.deliveryListLocalDataManager?.retrieveList(){
                            self.deliveryData = deliveries
                            expect(self.deliveryData.count > 0).to(equal(true))
                        }
                    } catch {
                        self.expectation(description: "Failed")
                    }
                }
            })
        }
    }
    
    private func saveData() {
        do {
            let deliveries = JSONUtil.getDeliveries()
            try self.deliveryListLocalDataManager?.saveDelivery(deliveries)
        }
        catch {
            self.deliveryData = []
        }
    }
    
    private func clearData() {
        do {
            try self.deliveryListLocalDataManager?.clearAllDelivery()
        }
        catch {
            self.deliveryData = []
        }
    }
}
