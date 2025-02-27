//
//  CartAction.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 26. 2. 25.
//

import Foundation
import SwiftUICoordinator

enum CartAction: CoordinatorAction {
    case dismissCart
    case showCheckout
    case dismissCheckout
    case didPurchase
}
