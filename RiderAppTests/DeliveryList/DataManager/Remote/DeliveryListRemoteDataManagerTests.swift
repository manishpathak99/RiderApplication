//
//  DeliveryListRemoteDataManager.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/9/19.
//

import Quick
import Nimble

@testable import RiderApp

// NOTE: Facing an issue in mocking the Alamofire library
class DeliveryListRemoteDataManagerSpec: QuickSpec {
    var deliveryListRemoteDataManager: DeliveryListRemoteDataManagerInputProtocol?

    private func setupModule(){
        self.deliveryListRemoteDataManager = DeliveryListRemoteDataManager()
        self.deliveryListRemoteDataManager?.remoteRequestHandler = MockRemoteOutputDataManager()
    }

    override func spec() {
        describe("DeliveryListRemoteDataManager") {
            beforeEach {
                self.setupModule()
            }
        }
    }
}
