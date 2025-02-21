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
    
    @Test func testStartShouldShowStartRoute() throws {
        // Arrange
        let navigator = MockNavigator(startRoute: .circle)
        
        // Act
        try navigator.start()
        
        guard let mockNavController = navigator.navigationController as? MockNavigationController else {
            Issue.record("Expected MockNavigationController but got a different type")
            return
        }
        
        // Assert
        #expect(mockNavController.pushedVC != nil)
    }
    
    @Test func testShowPresentsViewController() throws {
        // Arrange
        let navigator = MockNavigator(startRoute: .rectangle)
        
        // Act
        try navigator.start()
        
        guard let mockNavController = navigator.navigationController as? MockNavigationController else {
            Issue.record("Expected MockNavigationController but got a different type")
            return
        }
        
        // Assert
        #expect(mockNavController.presentedVC != nil)
        #expect(mockNavController.pushedVC == nil)
    }
    
    @Test func testShowRouteThrowsError() {
        // Arrange
        let navigator = MockNavigator(startRoute: .circle)
        
        // Act / Assert
        #expect {
            try navigator.show(route: .square)
        } throws: { error in
            return error is NavigatorError
        }
    }
    
    @Test func testShowRouteNoThrow() {
        // Arrange
        let navigator = MockNavigator(startRoute: .circle)
        
        // Act / Assert
        #expect(throws: Never.self) {
            try navigator.start()
        }
    }
    
    @Test func testSetUpdatesNavigationStack() {
        // Arrange
        let navigator = MockNavigator(startRoute: .circle)
        
        // Act
        navigator.set(routes: [.rectangle, .rectangle])
        
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
        navigator.append(routes: [.rectangle, .circle])
        
        // Assert
        #expect(navigator.viewControllers.count == 2)
    }

    @Test func testPopToRootRemovesAllButRoot() {
        // Arrange
        let navigator = MockNavigator(startRoute: .circle)
        navigator.append(routes: [.rectangle, .circle])
        
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
