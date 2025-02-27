//
//  CartViewModel.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 26. 2. 25.
//

import Foundation
import SwiftUICoordinator

@MainActor
final class CartViewModel: ObservableObject {
    
    let items: [CartItem] = CartItem.mock
    private let coordinator: CartCoordinator
    
    init(coordinator: CartCoordinator) {
        self.coordinator = coordinator
    }
    
    func onBackButtonTap() {
        coordinator.handle(CartAction.dismissCart)
    }
    
    func onCheckoutButtonTap() {
        coordinator.handle(CartAction.showCheckout)
    }
}
