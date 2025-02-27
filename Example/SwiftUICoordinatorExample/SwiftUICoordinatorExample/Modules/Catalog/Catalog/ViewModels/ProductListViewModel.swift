//
//  ProductListViewModel.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 25. 2. 25.
//

import Foundation
import SwiftUICoordinator

@MainActor
final class ProductListViewModel: ObservableObject {
    
    @Published var products: [ProductItem]
    private let coordinator: CatalogCoordinator
    
    init(coordinator: CatalogCoordinator) {
        self.coordinator = coordinator
        self.products = ProductItem.mock
    }
    
    func onCartTap() {
        coordinator.handle(CatalogAction.showCart)
    }
    
    func selectProduct(_ product: ProductItem) {
        coordinator.handle(CatalogAction.showProduct(product))
    }
}
