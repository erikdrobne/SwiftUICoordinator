//
//  LoginView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 24. 2. 25.
//

import SwiftUI
import SwiftUICoordinator

struct LoginView: View {
    
    @StateObject private var viewModel: LoginViewModel
    
    @FocusState private var currentFocus: FocusObject?
    enum FocusObject: Hashable { case email, pass }
    
    init(viewModel: @autoclosure @escaping () -> LoginViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 40)
                Text("Login")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                    .frame(height: 32)
                TextField("Email", text: $viewModel.email)
                    .focused($currentFocus, equals: .email)
                    .onAppear { currentFocus = .email }
                    .onSubmit { currentFocus = .pass }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .submitLabel(.continue)
                
                SecureField("Password", text: $viewModel.password)
                    .focused($currentFocus, equals: .pass)
                    .onSubmit { currentFocus = .pass }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                    .textContentType(.password)
                    .submitLabel(.done)
                Spacer()
                    .frame(height: 48)
                Button {
                    Task {
                        await viewModel.onLoginTap()
                    }
                } label: {
                    Text("Log in")
                        .frame(maxWidth: 300)
                        .padding()
                }
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(8)
                .padding(.horizontal)
                .disabled(!viewModel.isValid)
                
                Button {
                    viewModel.onForgotPasswordTap()
                } label: {
                    Text("Forgot password?")
                        .font(.footnote)
                }
                .padding(.top, 8)
                
                Button {
                    viewModel.onSignupTap()
                } label: {
                    Text("Sign up")
                }
                .padding(.horizontal)
                .padding(.top)
                
                Spacer()
            }
            if viewModel.isLoading {
                ProgressView("Loading")
            }
        }
    }
}

#Preview {
    LoginView(
        viewModel: LoginViewModel(
            coordinator: AuthCoordinator(
                parent: nil,
                navigationController: NavigationControllerFactory().makeNavigationController(),
                startRoute: .login
            )
        )
    )
}
