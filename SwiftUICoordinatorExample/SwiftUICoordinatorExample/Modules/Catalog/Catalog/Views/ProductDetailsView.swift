//
//  ProductDetailsView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 26. 2. 25.
//

import SwiftUI
import SwiftUICoordinator

struct ProductDetailsView: View {
    
    @StateObject private var viewModel: ProductDetailsViewModel
    
    init(viewModel: @autoclosure @escaping () -> ProductDetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Button {
                    viewModel.onBackButtonTap()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 24)
            
            productImage
            productInfo
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Spacer()
            
            addToCartButton
                .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }
    
    private var productImage: some View {
        viewModel.item.image
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.2))
            )
    }
    
    private var productInfo: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(viewModel.item.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(viewModel.item.description)
                .font(.body)
                .foregroundColor(.secondary)
                .lineSpacing(4)
            
            Text("$\(String(format: "%.2f", viewModel.item.price))")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.blue)
        }
    }
    
    private var addToCartButton: some View {
        Button {
            viewModel.addToCartTap()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "cart.badge.plus")
                    .font(.headline)
                Text("Add to Cart")
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue)
            )
            .shadow(radius: 3)
        }
    }
}

#Preview {
    ProductDetailsView(viewModel: ProductDetailsViewModel(
        item: ProductItem.mock.first!,
        coordinator: CatalogCoordinator(
            parent: nil,
            navigationController: NavigationControllerFactory().makeNavigationController(),
            factory: DependencyContainer.mock,
            startRoute: .productList
        )
    ))
}
