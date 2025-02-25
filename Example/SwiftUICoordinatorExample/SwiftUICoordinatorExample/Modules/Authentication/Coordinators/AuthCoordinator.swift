//
//  AuthCoordinator.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 24. 2. 25.
//

import SwiftUI
import SwiftUICoordinator

final class AuthCoordinator: Routing {
    
    weak var parent: Coordinator?
    var childCoordinators = [Coordinator]()
    let navigationController: UINavigationController
    var startRoute: AuthRoute
    
    init(
        parent: Coordinator?,
        navigationController: NavigationController,
        startRoute: AuthRoute = .login
    ) {
        self.parent = parent
        self.navigationController = navigationController
        self.startRoute = startRoute
    }
    
    func handle(_ action: CoordinatorAction) {
        switch action {
        case AuthAction.didLogin:
            try? show(route: .login)
        case AuthAction.didSignup:
            print("did signup")
        case AuthAction.showSignup:
            try? show(route: .signup)
        case AuthAction.showLogin:
            pop()
        case AuthAction.showResetPassword:
            try? show(route: .resetPassword)
        default:
            parent?.handle(action)
        }
    }
}

extension AuthCoordinator: RouterViewFactory {
    @ViewBuilder
    public func view(for route: AuthRoute) -> some View {
        switch route {
        case .login:
            LoginView(viewModel: LoginViewModel(coordinator: self))
        case .signup:
            SignupView(viewModel: SignupViewModel(coordinator: self))
        case .resetPassword:
            ResetPasswordView(viewModel: ResetPasswordViewModel(coordinator: self))
        }
    }
}
