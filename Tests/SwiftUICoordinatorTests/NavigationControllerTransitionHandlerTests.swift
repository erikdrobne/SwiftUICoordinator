//
//  NavigationControllerTransitionHandlerTests.swift
//  
//
//  Created by Erik Drobne on 23. 10. 23.
//

import Testing
import UIKit
@testable import SwiftUICoordinator

@MainActor
@Suite("NavigationControllerTransitionHandler Tests") struct NavigationControllerTransitionHandlerTests {
    
    @Test func testWhenTransitionIsEligible() {
        // Arrange
        let transitions = [MockTransition(), MockTransition()]
        let transitionHandler = NavigationControllerTransitionHandler(transitions: transitions)
        let mockFromVC = MockViewController(route: MockRoute.circle)
        let mockToVC = MockViewController(route: MockRoute.rectangle)
        let navigationController = NavigationController()
        
        // Act
        let animationController = transitionHandler.navigationController(
            navigationController,
            animationControllerFor: .push,
            from: mockFromVC,
            to: mockToVC
        )
        
        // Assert
        #expect(animationController != nil, "Animation controller should be returned for eligible transition.")
        #expect(animationController === transitions.first)
    }

    @Test func testWhenNoTransitionIsEligible() {
        // Arrange
        let transitions = [MockTransition(), MockTransition()]
        let transitionHandler = NavigationControllerTransitionHandler(transitions: transitions)
        let mockFromVC = MockViewController(route: MockRoute.square)
        let mockToVC = MockViewController(route: MockRoute.rectangle)
        let navigationController = NavigationController()
        
        // Act
        let animationController = transitionHandler.navigationController(
            navigationController,
            animationControllerFor: .push,
            from: mockFromVC,
            to: mockToVC
        )
        
        // Assert
        #expect(
            animationController == nil,
            "No animation controller should be returned for ineligible transition."
        )
    }
    
    @Test func testNoTransitionForNonRouteProviderViewController() {
        // Arrange
        let transitions = [MockTransition(), MockTransition()]
        let transitionHandler = NavigationControllerTransitionHandler(transitions: transitions)
        let mockFromVC = UIViewController()
        let mockToVC = MockViewController(route: MockRoute.rectangle)
        let navigationController = NavigationController()
        
        // Act
        let animationController = transitionHandler.navigationController(
            navigationController,
            animationControllerFor: .push,
            from: mockFromVC,
            to: mockToVC
        )
        
        // Assert
        #expect(
            animationController == nil,
            "No animation controller should be returned when fromVC doesn't conform to RouteProvider."
        )
    }
}
