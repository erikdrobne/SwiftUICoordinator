//
//  TransitionProviderTests.swift
//
//
//  Created by Erik Drobne on 23. 10. 23.
//

import XCTest
@testable import SwiftUICoordinator

class TransitionProviderTests: XCTestCase {
        
    @MainActor
    func test_transitionProviderInitialization() {
        let transitions = [MockTransition(), MockTransition()]
        let sut = TransitionProvider(transitions: transitions)
        
        XCTAssertEqual(sut.transitions.count, transitions.count)
        XCTAssertNotNil(sut.transitions.first?.transition)
    }
    
    @MainActor
    func test_weakTransitionDoesNotRetain() {
        var transition: Transitionable? = MockTransition()
        let weakTransition: WeakTransition? = WeakTransition(transition!)
        
        XCTAssertNotNil(weakTransition?.transition)
        transition = nil
        XCTAssertNil(weakTransition?.transition)
    }
}
