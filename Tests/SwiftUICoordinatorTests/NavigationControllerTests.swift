//
//  File.swift
//  
//
//  Created by Erik Drobne on 23/09/2023.
//

import Foundation
import XCTest
@testable import SwiftUICoordinator

final class NavigationControllerTests: XCTestCase {

    @MainActor
    func testNavigationBarIsHiddenByDefault() {
        // Act
        let navigationController = NavigationController()
        // Assert
        XCTAssertTrue(navigationController.isNavigationBarHidden)
    }

    @MainActor
    func testNavigationBarIsNotHidden() {
        // Act
        let navigationController = NavigationController(isNavigationBarHidden: false)
        // Assert
        XCTAssertFalse(navigationController.isNavigationBarHidden)
    }
    
    @MainActor
    func testNavigationControllerDelegate() {
        // Arrange
        let transitionDelegate = NavigationControllerFactory().makeTransitionDelegate([])
        let navigationController = NavigationController(isNavigationBarHidden: false, delegate: transitionDelegate)
        
        // Act
        let currentDelegate = navigationController.delegate
        
        // Assert
        XCTAssertNotNil(currentDelegate, "Delegate should not be nil")
        XCTAssertTrue(
            currentDelegate === transitionDelegate,
            "Delegate should be of type NavigationControllerTransitionDelegate"
        )
    }
}
