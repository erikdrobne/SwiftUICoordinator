//
//  NavigationController.swift
//  
//
//  Created by Erik Drobne on 12/05/2023.
//

import SwiftUI

@MainActor
public class NavigationController: UINavigationController {
    
    // MARK: - Initialization
    
    /// Initializes an instance of the class with optional customization for the navigation bar's visibility.
    ///
    /// - Parameter isNavigationBarHidden: A Boolean value indicating whether the navigation bar should be hidden on the created instance.
    /// If set to `true`, the navigation bar will be hidden. If set to `false`, the navigation bar will be displayed.
    ///
    /// - Note: By default `isNavigationBarHidden` is set to `true`.
    ///
    convenience init(isNavigationBarHidden: Bool = true, delegate: NavigationControllerDelegateProxy? = nil) {
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
