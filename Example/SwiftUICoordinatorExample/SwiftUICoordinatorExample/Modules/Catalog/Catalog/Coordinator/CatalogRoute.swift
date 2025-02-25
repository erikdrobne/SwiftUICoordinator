//
//  CatalogRoute.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 25. 2. 25.
//

import Foundation
import SwiftUICoordinator

enum CatalogRoute: StackNavigationRoute {
    case productList
    
    var action: TransitionAction {
        return .push(animated: true)
    }
}
