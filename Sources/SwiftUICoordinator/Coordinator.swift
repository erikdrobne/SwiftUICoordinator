//
//  Coordinator.swift
//  
//
//  Created by Erik Drobne on 12/12/2022.
//

import SwiftUI

@MainActor
public protocol Coordinator: AnyObject, CoordinatorNavigation {
    var parent: Coordinator? { get }
    var childCoordinators: [Coordinator] { get set }

    func finish()
    func add(child: Coordinator)
}

public extension Coordinator {
    func finish() {
        parent?.childCoordinators.removeAll(where: { $0 === self })
    }

    func add(child: Coordinator) {
        if !childCoordinators.contains(where: { $0 === child }) {
            childCoordinators.append(child)
        }
    }
}

public protocol CoordinatorNavigation {
    func presentRoot()
}
