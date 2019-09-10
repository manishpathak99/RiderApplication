//
//  Results.swift
//  RiderApp
//
//  Created by MANISH PATHAK on 9/6/19.
//

import RealmSwift

extension Results {
    func toArray() -> [Element] {
        return compactMap {
            $0
        }
    }
}
