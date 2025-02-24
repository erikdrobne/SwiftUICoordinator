//
//  TransitionTests.swift
//
//
//  Created by Erik Drobne on 10. 10. 23.
//

import Testing
import Foundation
@testable import SwiftUICoordinator

@MainActor
@Suite("Transition Tests") struct TransitionTests {

    @Test func testRegisterTransitions() {
        // Arrange
        let transition = MockTransition()
        let transitionHandler = NavigationControllerTransitionHandler(transitions: [transition])
        
        // Act
        let delegateProxy = NavigationControllerTransitionDelegate(transitionHandler: transitionHandler)
        let registeredTransition = delegateProxy.transitionHandler.transitions[0]
        
        // Assert
        #expect(registeredTransition is MockTransition)
        #expect(registeredTransition as? MockTransition == transition)
    }
    
    @Test func testEmptyTransitions() {
        // Arrange
        let transitionHandler = NavigationControllerTransitionHandler(transitions: [])
        
        // Act
        let delegateProxy = NavigationControllerTransitionDelegate(transitionHandler: transitionHandler)
        
        // Assert
        #expect(delegateProxy.transitionHandler.transitions.isEmpty)
    }
    
    @Test func testMultipleTransitions() {
        // Arrange
        let transition1 = MockTransition()
        let transition2 = MockTransition()
        let transitions = [transition1, transition2]
        
        // Act
        let transitionHandler = NavigationControllerTransitionHandler(transitions: transitions)
        let delegateProxy = NavigationControllerTransitionDelegate(transitionHandler: transitionHandler)
        
        // Assert
        #expect(delegateProxy.transitionHandler.transitions.count == 2)
        #expect(delegateProxy.transitionHandler.transitions[0] as? MockTransition == transition1)
        #expect(delegateProxy.transitionHandler.transitions[1] as? MockTransition == transition2)
    }
}
