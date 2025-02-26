//
//  CheckoutView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 27. 2. 25.
//

import SwiftUI
import SwiftUICoordinator

struct CheckoutView: View {
    @StateObject private var viewModel: CheckoutViewModel
    
    init(viewModel: @autoclosure @escaping () -> CheckoutViewModel) {
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
            
            ScrollView {
                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Order Summary")
                            .font(.title2)
                            .bold()
                        
                        ForEach(viewModel.items) { item in
                            HStack {
                                Text(item.product.name)
                                Spacer()
                                Text("$\(String(format: "%.2f", item.product.price))")
                            }
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Total")
                                .bold()
                            Spacer()
                            Text("$\(String(format: "%.2f", viewModel.total))")
                                .bold()
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Payment Details")
                            .font(.title2)
                            .bold()
                        
                        TextField("Card Number", text: $viewModel.cardNumber)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                        
                        TextField("MM/YY", text: $viewModel.expiryDate)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                }
                .padding()
            }
            
            Button {
                viewModel.onPayButtonTap()
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "creditcard.fill")
                        .font(.headline)
                    Text("Pay Now")
                        .font(.headline)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .padding()
        }
    }
}

#Preview {
    CheckoutView(viewModel: CheckoutViewModel(
        coordinator: CartCoordinator(
            parent: nil,
            navigationController: NavigationControllerFactory().makeNavigationController()
        )
    ))
}
