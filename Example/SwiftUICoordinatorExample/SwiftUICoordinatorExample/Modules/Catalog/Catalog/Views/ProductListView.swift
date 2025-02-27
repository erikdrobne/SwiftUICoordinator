//
//  ProductListView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 25. 2. 25.
//

import SwiftUI
import SwiftUICoordinator

struct ProductListView: View {
    
    @StateObject private var viewModel: ProductListViewModel
    
    init(viewModel: @autoclosure @escaping () -> ProductListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Catalog")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Button {
                    viewModel.onCartTap()
                } label: {
                    Image(systemName: "cart")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            .padding(.top, 24)
            
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 16) {
                    ForEach(viewModel.products) { product in
                        VStack {
                            product.image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .padding(8)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                            Text(product.name)
                                .font(.caption)
                        }
                        .onTapGesture {
                            viewModel.selectProduct(product)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ProductListView(viewModel: ProductListViewModel(
        coordinator: CatalogCoordinator(
            parent: nil,
            navigationController: NavigationControllerFactory().makeNavigationController(),
            factory: DependencyContainer.mock
        )
    ))
}
