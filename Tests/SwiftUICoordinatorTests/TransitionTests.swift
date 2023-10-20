//
//  TransitionTests.swift
//
//
//  Created by Erik Drobne on 10. 10. 23.
//

import XCTest
import Foundation
@testable import SwiftUICoordinator

@MainActor
final class TransitionTests: XCTestCase {
    
    func test_registerTransition() {
        let coordinator = MockCoordinator(
            parent: nil,
            startRoute: .circle,
            navigationController: NavigationController()
        )
        let transitions = [MockTransition()]
        
        coordinator.navigationController.register(transitions)
        
        guard let sut = coordinator.navigationController.transitions[0].transition as? MockTransition else {
            XCTFail("Cannot cast to MockTransition.")
            return
        }
        
        XCTAssertEqual(sut, transitions[0])
    }
    
    func test_unregisterTransition() {
        let sut = MockCoordinator(parent: nil, startRoute: .circle, navigationController: NavigationController())
        let transitions = [MockTransition(), MockTransition()]
        sut.navigationController.register(transitions)
        XCTAssertEqual(sut.navigationController.transitions.count, 2)
        
        sut.navigationController.unregister(MockTransition.self)
        XCTAssertEqual(sut.navigationController.transitions.count, 0)
    }
    
    func test_unregisterAllTransitions() {
        let sut = MockCoordinator(parent: nil, startRoute: .circle, navigationController: NavigationController())
        let transitions = [MockTransition(), MockTransition(), MockTransition()]
        sut.navigationController.register(transitions)
        XCTAssertEqual(sut.navigationController.transitions.count, 3)
        
        sut.navigationController.unregisterAllTransitions()
        XCTAssertEqual(sut.navigationController.transitions.count, 0)
    }
}
