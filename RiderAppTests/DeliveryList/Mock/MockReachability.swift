//
//  ReachableMock.swift
//  RiderAppTests
//
//  Created by MANISH PATHAK on 9/10/19.
//

@testable import RiderApp

class MockReachability: ReachabilityProtocol {
    var mockAvailablity = false
    init(mockAvailablity: Bool) {
        self.mockAvailablity = mockAvailablity
    }
    
    func isInternetAvailable() -> Bool {
        return mockAvailablity
    }
}
