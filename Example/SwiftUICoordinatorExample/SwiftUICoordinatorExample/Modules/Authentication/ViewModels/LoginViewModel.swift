//
//  LoginViewModel.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 24. 2. 25.
//

import SwiftUI
import SwiftUICoordinator

@MainActor
final class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading = false
    
    var isValid: Bool {
        !email.isEmpty && email.contains("@") && !password.isEmpty
    }
    
    private let coordinator: AuthCoordinator
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    func onLoginTap() async {
        guard !isLoading else {
            return
        }
        coordinator.handle(AuthAction.didLogin)
    }
    
    func onSignupTap() {
        coordinator.handle(AuthAction.showSignup)
    }
    
    func onForgotPasswordTap() {
        coordinator.handle(AuthAction.showResetPassword)
    }
}
