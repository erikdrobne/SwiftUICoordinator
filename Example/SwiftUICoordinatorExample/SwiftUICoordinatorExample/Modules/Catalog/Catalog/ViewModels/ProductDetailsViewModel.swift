//
//  ProductDetailsViewModel.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 26. 2. 25.
//

import Foundation
import SwiftUICoordinator

@MainActor
final class ProductDetailsViewModel: ObservableObject {
    
    let item: ProductItem
    private let coordinator: CatalogCoordinator
    
    init(item: ProductItem, coordinator: CatalogCoordinator) {
        self.item = item
        self.coordinator = coordinator
    }
    
    func onBackButtonTap() {
        coordinator.handle(CatalogAction.dismissProductDetails)
    }
    
    func addToCartTap() {
        coordinator.handle(CatalogAction.addedToCart)
    }
}
