//
//  RootCoordinatorTests.swift
//  
//
//  Created by Erik Drobne on 10. 10. 23.
//

import Testing
import UIKit
@testable import SwiftUICoordinator

@MainActor
@Suite("Root Coordinator Tests") struct RootCoordinatorTests {

    @Test func testRootViewControllerInitialization() {
        // Arrange
        let navigationController = NavigationController()
        let window = UIWindow()
        
        // Act
        let coordinator = MockAppCoordinator(window: window, navigationController: navigationController)
        
        // Assert
        #expect(coordinator.window == window)
        #expect(coordinator.window.isKeyWindow)
        #expect(!coordinator.window.isHidden)
        #expect(coordinator.window.rootViewController == navigationController)
        #expect(coordinator.childCoordinators.isEmpty)
    }
}
