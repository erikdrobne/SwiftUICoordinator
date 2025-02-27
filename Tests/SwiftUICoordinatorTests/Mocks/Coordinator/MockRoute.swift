//
//  MockRoute.swift
//  
//
//  Created by Erik Drobne on 25/05/2023.
//

import Foundation
import SwiftUICoordinator

enum MockRoute: StackNavigationRoute {
    case circle
    case rectangle
    case square
    
    var title: String? { nil }
    var appearance: RouteAppearance? { nil }
    var attachCoordinator: Bool { true }
    var hidesNavigationBar: Bool? { nil }
    var hidesBackButton: Bool? { nil }
    
    var action: TransitionAction {
        switch self {
        case .circle:
            return .push(animated: false)
        case .rectangle:
            return .present(animated: false, modalPresentationStyle: .automatic, delegate: nil, completion: nil)
        case .square:
            return .push(animated: false)
        }
    }
}
