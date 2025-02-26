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
    let image: Image
    
    static func == (lhs: ProductItem, rhs: ProductItem) -> Bool {
        lhs.id == rhs.id
    }
}

// swiftlint:disable line_length
extension ProductItem {
    static let mock = [
        ProductItem(id: "1", name: "Apple", description: "Fresh red apple", image: Image(systemName: "apple.logo")),
        ProductItem(id: "2", name: "Orange", description: "Juicy citrus fruit", image: Image(systemName: "circle.fill")),
        ProductItem(id: "3", name: "Milk", description: "Fresh dairy milk", image: Image(systemName: "cup.and.saucer.fill")),
        ProductItem(id: "4", name: "Bread", description: "Freshly baked bread", image: Image(systemName: "square.fill")),
        ProductItem(id: "5", name: "Water", description: "Pure natural spring water", image: Image(systemName: "drop.fill")),
        ProductItem(id: "6", name: "Bananas", description: "Yellow ripe bananas", image: Image(systemName: "moon.fill")),
        ProductItem(id: "7", name: "Eggs", description: "Farm fresh eggs", image: Image(systemName: "circle.fill")),
        ProductItem(id: "8", name: "Cheese", description: "Aged cheddar cheese", image: Image(systemName: "square.fill")),
        ProductItem(id: "9", name: "Tomatoes", description: "Vine ripened tomatoes", image: Image(systemName: "circle.fill")),
        ProductItem(id: "10", name: "Chicken", description: "Fresh chicken breast", image: Image(systemName: "leaf.fill")),
        ProductItem(id: "11", name: "Rice", description: "Long grain white rice", image: Image(systemName: "circle.grid.3x3.fill")),
        ProductItem(id: "12", name: "Pasta", description: "Italian spaghetti", image: Image(systemName: "line.3.horizontal")),
        ProductItem(id: "13", name: "Coffee", description: "Premium arabica coffee beans", image: Image(systemName: "cup.and.saucer.fill")),
        ProductItem(id: "14", name: "Tea", description: "English breakfast tea", image: Image(systemName: "cup.and.saucer")),
        ProductItem(id: "15", name: "Chocolate", description: "Dark chocolate bar", image: Image(systemName: "square.fill")),
        ProductItem(id: "16", name: "Yogurt", description: "Greek style yogurt", image: Image(systemName: "cup.and.saucer.fill")),
        ProductItem(id: "17", name: "Cereal", description: "Whole grain breakfast cereal", image: Image(systemName: "circle.grid.2x2.fill")),
        ProductItem(id: "18", name: "Butter", description: "Pure dairy butter", image: Image(systemName: "square.fill")),
        ProductItem(id: "19", name: "Honey", description: "Raw organic honey", image: Image(systemName: "drop.fill")),
        ProductItem(id: "20", name: "Chips", description: "Crispy potato chips", image: Image(systemName: "circle.grid.3x3.fill"))
    ]
}
// swiftlint:enable line_length
