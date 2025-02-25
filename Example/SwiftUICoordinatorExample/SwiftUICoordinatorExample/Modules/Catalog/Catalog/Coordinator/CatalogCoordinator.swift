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
    var startRoute: CatalogRoute
    
    init(
        parent: Coordinator?,
        navigationController: NavigationController,
        startRoute: CatalogRoute = .productList
    ) {
        self.parent = parent
        self.navigationController = navigationController
        self.startRoute = startRoute
    }
    
    func handle(_ action: CoordinatorAction) {
        switch action {
        case CatalogAction.showCart:
            print("show cart")
        case CatalogAction.showProduct(let product):
            print("show product")
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
        }
    }
}
