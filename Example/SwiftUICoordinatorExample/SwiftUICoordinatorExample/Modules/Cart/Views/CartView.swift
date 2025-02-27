//
//  CartView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 26. 2. 25.
//

import SwiftUI
import SwiftUICoordinator

struct CartView: View {
    @StateObject private var viewModel: CartViewModel
    
    init(viewModel: @autoclosure @escaping () -> CartViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        VStack(spacing: 16) {
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
            
            if viewModel.items.isEmpty {
                Spacer()
                emptyCartView
            } else {
                cartItemsList
            }
            
            Spacer()
            
            if !viewModel.items.isEmpty {
                checkoutButton
                    .padding()
            }
        }
    }
    
    private var emptyCartView: some View {
        VStack(spacing: 16) {
            Image(systemName: "cart")
                .font(.system(size: 64))
                .foregroundColor(.gray)
            Text("Your cart is empty")
                .font(.title2)
                .foregroundColor(.gray)
        }
    }
    
    private var cartItemsList: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(viewModel.items) { item in
                    CartItemView(item: item.product) {}
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var checkoutButton: some View {
        Button {
            viewModel.onCheckoutButtonTap()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "creditcard")
                    .font(.headline)
                Text("Proceed to Checkout")
                    .font(.headline)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
    }
}

#Preview {
    CartView(viewModel: CartViewModel(
        coordinator: CartCoordinator(
            parent: nil,
            navigationController: NavigationControllerFactory().makeNavigationController()
        )
    ))
}
