//
//  CartItemView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 26. 2. 25.
//

import SwiftUI

struct CartItemView: View {
    
    let item: ProductItem
    let onRemove: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            item.image
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                Text(item.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: onRemove) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding()
    }
}

#Preview {
    CartItemView(item: .mock.first!) {
        
    }
}
