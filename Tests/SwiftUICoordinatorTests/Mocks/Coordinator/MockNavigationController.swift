//
//  MockNavigationController.swift
//  SwiftUICoordinator
//
//  Created by Erik Drobne on 7. 2. 25.
//

import UIKit
import SwiftUICoordinator

final class MockNavigationController: UINavigationController {
    private(set) var pushedVC: UIViewController?
    private(set) var presentedVC: UIViewController?
    private(set) var dismissed = false
    private(set) var setViewControllersCallCount = 0
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
    
    override func present(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
        presentedVC = viewController
        super.present(viewController, animated: animated, completion: completion)
    }
    
    override func dismiss(animated: Bool, completion: (() -> Void)? = nil) {
        dismissed = true
        super.dismiss(animated: animated, completion: completion)
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        setViewControllersCallCount += 1
        super.setViewControllers(viewControllers, animated: animated)
    }
}
