//
//  CartCoordinator.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 26. 2. 25.
//

import SwiftUI
import SwiftUICoordinator

final class CartCoordinator: Routing {
    
    weak var parent: Coordinator?
    var childCoordinators = [Coordinator]()
    let navigationController: UINavigationController
    let startRoute: CartRoute
    
    init(
        parent: Coordinator?,
        navigationController: NavigationController,
        startRoute: CartRoute = .cart
    ) {
        self.parent = parent
        self.navigationController = navigationController
        self.startRoute = startRoute
    }
    
    func handle(_ action: CoordinatorAction) {
        switch action {
        case CartAction.dismissCart:
            parent?.handle(Action.cancel(self))
        case CartAction.showCheckout:
            show(route: .checkout)
        case CartAction.dismissCheckout:
            pop()
        case CartAction.didPurchase:
            parent?.handle(Action.done(self))
        default:
            parent?.handle(action)
        }
    }
}

extension CartCoordinator: RouterViewFactory {
    @ViewBuilder
    public func view(for route: CartRoute) -> some View {
        switch route {
        case .cart:
            CartView(viewModel: CartViewModel(coordinator: self))
        case .checkout:
            CheckoutView(viewModel: CheckoutViewModel(coordinator: self))
        }
    }
}
