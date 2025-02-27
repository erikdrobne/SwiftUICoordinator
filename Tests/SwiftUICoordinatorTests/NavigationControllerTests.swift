//
//  File.swift
//  
//
//  Created by Erik Drobne on 23/09/2023.
//

import Testing
@testable import SwiftUICoordinator

@MainActor
@Suite("Navigation Controller Tests") struct NavigationControllerTests {

    @Test func testNavigationBarIsHiddenByDefault() {
        // Act
        let navigationController = NavigationController()
        
        // Assert
        #expect(navigationController.isNavigationBarHidden)
    }

    @Test func testNavigationBarIsNotHidden() {
        // Act
        let navigationController = NavigationController(isNavigationBarHidden: false)
        
        // Assert
        #expect(!navigationController.isNavigationBarHidden)
    }
    
    @Test func testNavigationControllerDelegate() {
        // Arrange
        let transitionDelegate = NavigationControllerFactory().makeTransitionDelegate([])
        let navigationController = NavigationController(
            isNavigationBarHidden: false,
            delegate: transitionDelegate
        )
        
        // Act
        let currentDelegate = navigationController.delegate
        
        // Assert
        #expect(currentDelegate != nil, "Delegate should not be nil")
        #expect(
            currentDelegate === transitionDelegate,
            "Delegate should be of type NavigationControllerTransitionDelegate"
        )
    }
}
