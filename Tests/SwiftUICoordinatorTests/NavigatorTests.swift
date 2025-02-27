//
//  NavigatorTests.swift
//
//
//  Created by Erik Drobne on 24. 10. 23.
//

import Testing
@testable import SwiftUICoordinator

@MainActor
@Suite("Navigator Tests") struct NavigatorTests {
    
    @Test func testStartShouldShowStartRoute() {
        // Arrange
        let navigator = MockNavigator(startRoute: .circle)
        
        // Act
        navigator.start()
        
        guard let mockNavController = navigator.navigationController as? MockNavigationController else {
            Issue.record("Expected MockNavigationController but got a different type")
            return
        }
        
        // Assert
        #expect(mockNavController.pushedVC != nil)
    }
    
    @Test func testShowPresentsViewController() {
        // Arrange
        let navigator = MockNavigator(startRoute: .rectangle)
        
        // Act
        navigator.start()
        
        guard let mockNavController = navigator.navigationController as? MockNavigationController else {
            Issue.record("Expected MockNavigationController but got a different type")
            return
        }
        
        // Assert
        #expect(mockNavController.presentedVC != nil)
        #expect(mockNavController.pushedVC == nil)
    }
    
    @Test func testShowRoute() {
        // Arrange
        let navigator = MockNavigator(startRoute: .circle)
        
        // Act
        navigator.show(route: .square)
        
        guard let mockNavController = navigator.navigationController as? MockNavigationController else {
            Issue.record("Expected MockNavigationController but got a different type")
            return
        }
        
        // Assert
        #expect(mockNavController.pushedVC != nil)
    }
    
    @Test func testSetUpdatesNavigationStack() {
        // Arrange
        let navigator = MockNavigator(startRoute: .circle)
        
        // Act
        navigator.set(routes: [.rectangle, .rectangle], animated: false)
        
        guard let mockNavController = navigator.navigationController as? MockNavigationController else {
            Issue.record("Expected MockNavigationController but got a different type")
            return
        }
        
        // Assert
        #expect(navigator.viewControllers.count == 2)
        #expect(mockNavController.setViewControllersCallCount == 1)
    }
    
    @Test func testAppendAddsToNavigationStack() {
        // Arrange
        let navigator = MockNavigator(startRoute: .circle)
        
        // Act
        navigator.append(routes: [.rectangle, .circle], animated: false)
        
        // Assert
        #expect(navigator.viewControllers.count == 2)
    }

    @Test func testPopToRootRemovesAllButRoot() {
        // Arrange
        let navigator = MockNavigator(startRoute: .circle)
        navigator.append(routes: [.rectangle, .circle], animated: false)
        
        // Act / Assert
        #expect(navigator.viewControllers.count == 2)
        navigator.popToRoot(animated: false)
        #expect(navigator.viewControllers.count == 1)
    }
    
    @Test func testDismissCallsDismiss() {
        // Arrange
        let navigator = MockNavigator(startRoute: .circle)
        
        // Act
        navigator.dismiss(animated: false)
        
        guard let mockNavController = navigator.navigationController as? MockNavigationController else {
            Issue.record("Expected MockNavigationController but got a different type")
            return
        }
        
        // Assert
        #expect(mockNavController.dismissed)
    }
}
