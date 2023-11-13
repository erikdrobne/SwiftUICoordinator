//
//  TransitionAction.swift
//  
//
//  Created by Erik Drobne on 12/12/2022.
//

import SwiftUI

public enum TransitionAction {
    /// Represents a push action for pushing a view controller onto a navigation stack.
    case push(animated: Bool)
    /// Represents a present action for presenting a view controller modally.
    case present(
        animated: Bool = true,
        modalPresentationStyle: UIModalPresentationStyle = .automatic,
        delegate: UIViewControllerTransitioningDelegate? = nil,
        completion: (() -> Void)? = nil
    )
}
