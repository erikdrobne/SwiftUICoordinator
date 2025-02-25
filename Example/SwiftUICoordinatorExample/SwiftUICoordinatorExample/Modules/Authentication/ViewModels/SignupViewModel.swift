//
//  SignupViewModel.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 25. 2. 25.
//

import SwiftUI
import SwiftUICoordinator

@MainActor
final class SignupViewModel: ObservableObject {
    
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var acceptedTerms: Bool = false
    @Published var isLoading = false
    
    var isValid: Bool {
        !fullName.isEmpty &&
        !email.isEmpty &&
        email.contains("@") &&
        password.count >= 8 &&
        password == confirmPassword &&
        acceptedTerms
    }
    
    private let coordinator: AuthCoordinator
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
    func onSignupTap() async {
        guard !isLoading else {
            return
        }
        
        isLoading = true
        try? await Task.sleep(nanoseconds: NSEC_PER_SEC * 2)
        isLoading = false
        
        coordinator.handle(AuthAction.didSignup)
    }
    
    func onLoginTap() {
        coordinator.handle(AuthAction.showLogin)
    }
}
