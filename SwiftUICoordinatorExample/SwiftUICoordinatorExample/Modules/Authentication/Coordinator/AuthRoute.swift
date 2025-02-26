//
//  AuthRoute.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 24. 2. 25.
//

import Foundation
import SwiftUICoordinator

enum AuthRoute: StackNavigationRoute {
    case login
    case signup
    case resetPassword
    
    var action: TransitionAction {
        return .push(animated: true)
    }
}
