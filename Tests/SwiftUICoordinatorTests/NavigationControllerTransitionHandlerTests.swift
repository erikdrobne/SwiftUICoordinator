//
//  NavigationControllerTransitionHandlerTests.swift
//  
//
//  Created by Erik Drobne on 23. 10. 23.
//

import XCTest
@testable import SwiftUICoordinator

final class NavigationControllerTransitionHandlerTests: XCTestCase {

    @MainActor
    func testWhenTransitionIsEligible() {
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
        XCTAssertNotNil(animationController, "Animation controller should be returned for eligible transition.")
        XCTAssertTrue(animationController is MockTransition, "Returned animation controller should be of type MockTransition.")
    }

    @MainActor
    func testWhenNoTransitionIsEligible() {
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
        XCTAssertNil(
            animationController,
            "No animation controller should be returned for ineligible transition."
        )
    }
    
    @MainActor
    func testNoTransitionForNonRouteProviderViewController() {
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
        XCTAssertNil(
            animationController,
            "No animation controller should be returned when fromVC doesn't conform to RouteProvider."
        )
    }
}
