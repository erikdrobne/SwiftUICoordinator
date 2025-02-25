//
//  CoordinatorFactory.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 5. 10. 23.
//

import SwiftUI
import SwiftUICoordinator

@MainActor
protocol CoordinatorFactory {
    func makeTabsCoordinator(parent: Coordinator) -> TabsCoordinator
    func makeAuthCoordinator(parent: Coordinator) -> AuthCoordinator
}
