//
//  CatalogCoordinator.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 25. 2. 25.
//

import SwiftUI
import SwiftUICoordinator

final class CatalogCoordinator: Routing {
    
    weak var parent: Coordinator?
    var childCoordinators = [Coordinator]()
    let navigationController: UINavigationController
    let startRoute: CatalogRoute
    
    private let factory: CoordinatorFactory
    
    init(
        parent: Coordinator?,
        navigationController: NavigationController,
        factory: CoordinatorFactory,
        startRoute: CatalogRoute = .productList
    ) {
        self.parent = parent
        self.navigationController = navigationController
        self.factory = factory
        self.startRoute = startRoute
    }
    
    func handle(_ action: CoordinatorAction) {
        switch action {
        case CatalogAction.showCart:
            let cartCoordinator = factory.makeCartCoordinator(parent: self)
            self.add(child: cartCoordinator)
            cartCoordinator.start()
        case CatalogAction.showProduct(let product):
            show(route: .productDetails(product))
        case CatalogAction.dismissProductDetails, CatalogAction.addedToCart:
            pop()
        case Action.cancel(let cartCoordinator as CartCoordinator):
            self.remove(coordinator: cartCoordinator)
            self.popToRoot()
        case Action.done(let cartCoordinator as CartCoordinator):
            self.remove(coordinator: cartCoordinator)
            self.popToRoot()
        default:
            parent?.handle(action)
        }
    }
}

extension CatalogCoordinator: RouterViewFactory {
    @ViewBuilder
    public func view(for route: CatalogRoute) -> some View {
        switch route {
        case .productList:
            ProductListView(viewModel: ProductListViewModel(coordinator: self))
        case .productDetails(let product):
            ProductDetailsView(viewModel: ProductDetailsViewModel(item: product, coordinator: self))
        }
    }
}
