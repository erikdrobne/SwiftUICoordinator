//
//  AuthAction.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 24. 2. 25.
//

import Foundation
import SwiftUICoordinator

enum AuthAction: CoordinatorAction {
    case didLogin
    case didSignup
    case showLogin
    case showSignup
    case showResetPassword
}
