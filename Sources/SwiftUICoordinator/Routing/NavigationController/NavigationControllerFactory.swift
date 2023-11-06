//
//  File.swift
//  
//
//  Created by Erik Drobne on 19. 10. 23.
//

import Foundation

@MainActor
protocol NavigationControllerCreatable {
    func makeNavigationDelegate(_ transitions: [Transitionable]) -> NavigationControllerDelegateProxy?
    func makeNavigationController(
        isNavigationBarHidden: Bool,
        delegate: NavigationControllerDelegateProxy?
    ) -> NavigationController
}

public final class NavigationControllerFactory: NavigationControllerCreatable {
    
    public init() {}
    
    public func makeNavigationDelegate(_ transitions: [Transitionable]) -> NavigationControllerDelegateProxy? {
        let transitionProvider = TransitionProvider(transitions: transitions)
        let transitionHandler = NavigationControllerTransitionHandler(provider: transitionProvider)
        return NavigationControllerDelegateProxy(transitionHandler: transitionHandler)
    }
    
    public func makeNavigationController(
        isNavigationBarHidden: Bool = true,
        delegate: NavigationControllerDelegateProxy? = nil
    ) -> NavigationController {
        return NavigationController(isNavigationBarHidden: isNavigationBarHidden, delegate: delegate)
    }
}