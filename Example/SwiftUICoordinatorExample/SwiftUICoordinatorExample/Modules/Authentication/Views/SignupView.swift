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
    
    @FocusState private var currentFocus: FocusObject?
    enum FocusObject: Hashable { case name, email, pass, passConfirm }
    
    init(viewModel: @autoclosure @escaping () -> SignupViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel())
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
                    .focused($currentFocus, equals: .name)
                    .onAppear { currentFocus = .name }
                    .onSubmit { currentFocus = .email }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .autocapitalization(.words)
                    .autocorrectionDisabled(true)
                    .keyboardType(.namePhonePad)
                    .textContentType(.name)
                    .submitLabel(.continue)
                TextField("Email", text: $viewModel.email)
                    .focused($currentFocus, equals: .email)
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
                    .onSubmit { currentFocus = .passConfirm }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                    .textContentType(.password)
                    .submitLabel(.continue)
                SecureField("Confirm Password", text: $viewModel.confirmPassword)
                    .focused($currentFocus, equals: .passConfirm)
                    .onSubmit { currentFocus = nil }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .autocapitalization(.none)
                    .autocorrectionDisabled(true)
                    .textContentType(.password)
                    .submitLabel(.done)
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
                
                Spacer()
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
