//
//  CatalogRoute.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 25. 2. 25.
//

import Foundation
import SwiftUICoordinator

enum CatalogRoute: StackNavigationRoute, Equatable {
    case productList
    case productDetails(ProductItem)
    
    var action: TransitionAction {
        return .push(animated: true)
    }
    
    nonisolated static func == (lhs: CatalogRoute, rhs: CatalogRoute) -> Bool {
        switch (lhs, rhs) {
        case (.productList, .productList):
            return true
        case let (.productDetails(lhsItem), .productDetails(rhsItem)):
            return lhsItem == rhsItem
        default:
            return false
        }
    }
}
