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
    func test_animationForEligibleRoutes() {
        let provider = TransitionProvider(transitions: [MockTransition(), MockTransition()])
        let handler = NavigationControllerTransitionHandler(provider: provider)
        
        let mockFromVC = RouteHostingController(rootView: CircleView(), route: MockRoute.circle)
        let mockToVC = RouteHostingController(rootView: RectangleView(), route: MockRoute.rectangle)
        let sut = handler.navigationController(
            NavigationController(),
            animationControllerFor: .push,
            from: mockFromVC,
            to: mockToVC
        )
        
        XCTAssertTrue(sut is MockTransition)
    }
    
    @MainActor
    func test_animationForNoMatchingTransitions() {
        let provider = TransitionProvider(transitions: [])
        let handler = NavigationControllerTransitionHandler(provider: provider)
        
        let mockFromVC = RouteHostingController(rootView: CircleView(), route: MockRoute.circle)
        let mockToVC = RouteHostingController(rootView: RectangleView(), route: MockRoute.rectangle)
        let sut = handler.navigationController(
            NavigationController(),
            animationControllerFor: .push,
            from: mockFromVC,
            to: mockToVC
        )
        
        XCTAssertNil(sut)
    }
}
