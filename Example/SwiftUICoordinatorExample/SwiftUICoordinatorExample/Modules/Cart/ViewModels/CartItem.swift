//
//  CartItem.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 26. 2. 25.
//

import SwiftUI

struct CartItem: Identifiable {
    let id: UUID
    let product: ProductItem
    var quantity: Int
    
    var totalPrice: Double {
        Double(quantity) * product.price
    }
    
    init(product: ProductItem, quantity: Int = 1, id: UUID = UUID()) {
        self.id = id
        self.product = product
        self.quantity = quantity
    }
}

extension CartItem {
    var image: Image {
        product.image
    }
    
    var name: String {
        product.name
    }
    
    var description: String {
        product.description
    }
    
    var price: Double {
        product.price
    }
}

extension CartItem {
    static let mock: [CartItem] = [
        CartItem(product: ProductItem.mock[0], quantity: 1),
        CartItem(product: ProductItem.mock[1], quantity: 2),
        CartItem(product: ProductItem.mock[2], quantity: 1),
        CartItem(product: ProductItem.mock[3], quantity: 1)
    ]
}
