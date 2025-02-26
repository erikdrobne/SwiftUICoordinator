//
//  CheckoutViewModel.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 27. 2. 25.
//

import Foundation
import SwiftUICoordinator

@MainActor
final class CheckoutViewModel: ObservableObject {
    
    let items: [CartItem] = CartItem.mock
    private let coordinator: CartCoordinator
    
    @Published var cardNumber: String = ""
    @Published var expiryDate: String = ""
    
    var total: Double {
        items.reduce(0) { $0 + $1.product.price }
    }

    init(coordinator: CartCoordinator) {
        self.coordinator = coordinator
    }

    func onPayButtonTap() {
        coordinator.handle(CartAction.didPurchase)
    }
    
    func onBackButtonTap() {
        coordinator.handle(CartAction.dismissCheckout)
    }
}
