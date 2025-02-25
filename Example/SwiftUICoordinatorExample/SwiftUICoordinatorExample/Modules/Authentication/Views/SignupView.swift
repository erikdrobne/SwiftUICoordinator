//
//  SignupView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 25. 2. 25.
//

import SwiftUI
import SwiftUICoordinator

struct SignupView: View {
    
    @StateObject private var viewModel: SignupViewModel
    
    init(viewModel: @autoclosure @escaping () -> SignupViewModel) {
        print("SignupView init called")
        let vm = viewModel()
        print("ViewModel created: \(ObjectIdentifier(vm))")
        _viewModel = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                    .frame(height: 40)
                Text("Signup")
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                    .frame(height: 32)
                TextField("Full Name", text: $viewModel.fullName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.words)
                    .padding(.horizontal)
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding(.horizontal)
                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                Toggle(isOn: $viewModel.acceptedTerms) {
                    Text("I accept the Terms and Conditions")
                        .font(.footnote)
                }
                .padding(.horizontal)
                .padding(.top, 8)
                Spacer()
                    .frame(height: 48)
                Button {
                    Task {
                        await viewModel.onSignupTap()
                    }
                } label: {
                    Text("Sign Up")
                        .frame(maxWidth: 300)
                        .padding()
                }
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(8)
                .padding(.horizontal)
                .disabled(!viewModel.isValid)
                
                Button {
                    viewModel.onLoginTap()
                } label: {
                    Text("Already have an account? Log in")
                }
                .padding(.horizontal)
                .padding(.top)
            }
            if viewModel.isLoading {
                ProgressView("Loading")
            }
        }
    }
}

#Preview {
    SignupView(
        viewModel: SignupViewModel(
            coordinator: AuthCoordinator(
                parent: nil,
                navigationController: NavigationControllerFactory().makeNavigationController(),
                startRoute: .login
            )
        )
    )
}
