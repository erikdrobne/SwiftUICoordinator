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
        let coordinator = MockCoordinator(parent: nil, startRoute: .circle)
        let transitions = [MockTransition()]
        
        coordinator.navigationController.register(transitions)
        
        guard let mockTransition = coordinator.navigationController.transitions[0].transition as? MockTransition else {
            XCTFail("Cannot cast to MockTransition.")
            return
        }
        
        XCTAssertEqual(mockTransition, transitions[0])
    }
    
    func test_unregisterTransition() {
        let coordinator = MockCoordinator(parent: nil, startRoute: .circle)
        let transitions = [MockTransition(), MockTransition()]
        coordinator.navigationController.register(transitions)
        XCTAssertEqual(coordinator.navigationController.transitions.count, 2)
        
        coordinator.navigationController.unregister(MockTransition.self)
        XCTAssertEqual(coordinator.navigationController.transitions.count, 0)
    }
    
    func test_unregisterAllTransitions() {
        let coordinator = MockCoordinator(parent: nil, startRoute: .circle)
        let transitions = [MockTransition(), MockTransition(), MockTransition()]
        coordinator.navigationController.register(transitions)
        XCTAssertEqual(coordinator.navigationController.transitions.count, 3)
        
        coordinator.navigationController.unregisterAllTransitions()
        XCTAssertEqual(coordinator.navigationController.transitions.count, 0)
    }
}
