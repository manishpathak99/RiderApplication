//
//  Endpoints.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {

    enum Deliveries: Endpoint {
        case fetch

        public var path: String {
            switch self {
            case .fetch: return "/deliveries"
            }
        }

        public var url: String {
            switch self {
            case .fetch: return "\(Constants.AppAPI.baseUrl)\(path)"
            }
        }
    }
}
