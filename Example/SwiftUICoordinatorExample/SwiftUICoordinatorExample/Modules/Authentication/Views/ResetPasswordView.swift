//
//  ResetPasswordView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 25. 2. 25.
//

import SwiftUI
import SwiftUICoordinator

struct ResetPasswordView: View {
    @StateObject private var viewModel: ResetPasswordViewModel
    
    init(viewModel: @autoclosure @escaping () -> ResetPasswordViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 40)
                Text("Reset Password")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Enter your email address and we'll send you instructions to reset your password.")
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    .frame(height: 32)
                
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .submitLabel(.done)
                
                Spacer()
                    .frame(height: 48)
                
                Button {
                    Task {
                        await viewModel.onResetPasswordTap()
                    }
                } label: {
                    Text("Send Reset Link")
                        .frame(maxWidth: 300)
                        .padding()
                }
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(8)
                .padding(.horizontal)
                .disabled(!viewModel.isValid)
                
                Button {
                    viewModel.onBackToLoginTap()
                } label: {
                    Text("Back to Login")
                }
                .padding(.horizontal)
                .padding(.top)
                
                Spacer()
            }
            
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }
}

#Preview {
    ResetPasswordView(
        viewModel: ResetPasswordViewModel(
            coordinator: AuthCoordinator(
                parent: nil,
                navigationController: NavigationControllerFactory().makeNavigationController(),
                startRoute: .login
            )
        )
    )
}
