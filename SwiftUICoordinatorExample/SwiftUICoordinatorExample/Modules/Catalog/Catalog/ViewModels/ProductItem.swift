//
//  ProductItem.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 25. 2. 25.
//

import Foundation
import SwiftUI

struct ProductItem: Identifiable, Equatable {
    let id: String
    let name: String
    let description: String
    let price: Double
    let image: Image
    
    static func == (lhs: ProductItem, rhs: ProductItem) -> Bool {
        lhs.id == rhs.id
    }
}

// swiftlint:disable line_length
extension ProductItem {
    static let mock = [
        ProductItem(id: "1", name: "Apple", description: "Fresh red apple", price: 0.99, image: Image(systemName: "apple.logo")),
        ProductItem(id: "2", name: "Orange", description: "Juicy citrus fruit", price: 0.79, image: Image(systemName: "circle.fill")),
        ProductItem(id: "3", name: "Coffee", description: "Premium coffee beans", price: 12.99, image: Image(systemName: "cup.and.saucer.fill")),
        ProductItem(id: "4", name: "Tea", description: "Breakfast tea", price: 4.99, image: Image(systemName: "cup.and.saucer")),
        ProductItem(id: "5", name: "Rice", description: "Long grain white rice", price: 4.49, image: Image(systemName: "circle.grid.3x3.fill")),
        ProductItem(id: "6", name: "Water", description: "Natural water", price: 1.49, image: Image(systemName: "drop.fill"))
    ]
}
// swiftlint:enable line_length
