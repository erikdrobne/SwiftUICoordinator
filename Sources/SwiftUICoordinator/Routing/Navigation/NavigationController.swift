//
//  NavigationController.swift
//  
//
//  Created by Erik Drobne on 12/05/2023.
//

import UIKit

@MainActor
public final class NavigationController: UINavigationController {

    /// Initializes an instance of the class with optional customization for the navigation bar's visibility.
    ///
    /// - Parameters:
    ///   - isNavigationBarHidden: A Boolean value indicating whether the navigation bar should be
    ///     hidden on the created instance. If set to `true`, the navigation bar will be hidden.
    ///     If set to `false`, the navigation bar will be displayed.
    ///   - delegate: An optional `NavigationControllerTransitionDelegate` object to set as the delegate.
    ///
    /// - Note: By default, `isNavigationBarHidden` is set to `true`.
    ///
    convenience init(isNavigationBarHidden: Bool = true, delegate: NavigationControllerTransitionDelegate? = nil) {
        self.init(nibName: nil, bundle: nil)

        self.isNavigationBarHidden = isNavigationBarHidden
        self.delegate = delegate
    }

    private override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
