//
//  Navigator.swift
//  
//
//  Created by Erik Drobne on 12/12/2022.
//

import SwiftUI

public typealias Routing = Coordinator & Navigator

/// A protocol for navigating and managing view controllers within a navigation stack.
@MainActor
public protocol Navigator: ObservableObject {
    associatedtype Route: StackNavigationRoute

    var navigationController: UINavigationController { get }
    /// The starting route of the navigator.
    var startRoute: Route { get }
    
    /// This method should be called to start the flow and to show the view for the `startRoute`.
    func start()
    /// It creates a view for the route and adds it to the navigation stack.
    func show(route: Route)
    /// Creates views for routes, and replaces the navigation stack with the specified views.
    func set(routes: [Route], animated: Bool)
    /// Creates views for routes, and appends them on the navigation stack.
    func append(routes: [Route], animated: Bool)
    /// Pops the top view from the navigation stack.
    func pop(animated: Bool)
    /// Pops all the views on the stack except the root view.
    func popToRoot(animated: Bool)
    /// Dismisses the view.
    func dismiss(animated: Bool)
}

// MARK: - Extensions

public extension Navigator where Self: RouterViewFactory {
    
    // MARK: - Public properties

    var viewControllers: [UIViewController] {
        return navigationController.viewControllers
    }

    var topViewController: UIViewController? {
        return navigationController.topViewController
    }

    var visibleViewController: UIViewController? {
        return navigationController.visibleViewController
    }
    
    // MARK: - Public methods

    func start() {
        show(route: startRoute)
    }

    func show(route: Route) {
        let viewController = self.hostingController(for: route)
        navigationController.isNavigationBarHidden = route.title == nil && route.hidesNavigationBar ?? true

        switch route.action {
        case .push(let animated):
            navigationController.pushViewController(viewController, animated: animated)
        case .present(let animated, let modalPresentationStyle, let delegate, let completion):
            present(
                viewController: viewController,
                animated: animated,
                modalPresentationStyle: modalPresentationStyle,
                delegate: delegate,
                completion: completion
            )
        }
    }

    func set(routes: [Route], animated: Bool = true) {
        let views = views(for: routes)
        updateNavigationBarVisibility(for: routes)
        navigationController.setViewControllers(views, animated: animated)
    }

    func append(routes: [Route], animated: Bool = true) {
        let views = views(for: routes)
        updateNavigationBarVisibility(for: routes)
        navigationController.setViewControllers(self.viewControllers + views, animated: animated)
    }

    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }

    func popToRoot(animated: Bool = true) {
        if navigationController.presentedViewController != nil {
            navigationController.dismiss(animated: animated)
        }
        navigationController.popToRootViewController(animated: animated)
    }

    func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: animated)
    }

    // MARK: - Private methods

    private func present(
        viewController: UIViewController,
        animated: Bool,
        modalPresentationStyle: UIModalPresentationStyle,
        delegate: UIViewControllerTransitioningDelegate?,
        completion: (() -> Void)?
    ) {
        if let delegate {
            viewController.modalPresentationStyle = .custom
            viewController.transitioningDelegate = delegate
        } else {
            viewController.modalPresentationStyle = modalPresentationStyle
        }
        
        navigationController.present(viewController, animated: animated, completion: completion)
    }
    
    private func updateNavigationBarVisibility(for routes: [Route]) {
        let hidesNavigationBar = routes.last?.hidesNavigationBar ?? true
        navigationController.isNavigationBarHidden = routes.last?.title == nil && hidesNavigationBar
    }
}
