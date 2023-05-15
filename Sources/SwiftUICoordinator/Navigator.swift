//
//  Navigator.swift
//  
//
//  Created by Erik Drobne on 12/12/2022.
//

import SwiftUI

public typealias Routing = Coordinator & Navigator

@MainActor
public protocol Navigator: ObservableObject {
    associatedtype Route: NavigationRoute

    var navigationController: UINavigationController { get set }
    var startRoute: Route? { get }
    
    func start() throws
    func show(route: Route) throws
    func set(routes: [Route], animated: Bool)
    func append(routes: [Route], animated: Bool)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func dismiss(animated: Bool)
}

public extension Navigator where Self: Coordinator, Self: RouterViewFactory {

    var viewControllers: [UIViewController] {
        return navigationController.viewControllers
    }

    var topViewController: UIViewController? {
        return navigationController.topViewController
    }

    var visibleViewController: UIViewController? {
        return navigationController.visibleViewController
    }

    func start() throws {
        guard let route = startRoute else {
            return
        }
        
        try show(route: route)
    }

    func show(route: Route) throws {
        let view = self.view(for: route)
            .ifLet(route.title) { view, value in
                view.navigationTitle(value)
            }

        let viewWithCoordinator = view.environmentObject(self)
        let viewController = CoordinatorHostingController(
            rootView: viewWithCoordinator,
            route: route
        )
        
        switch route.transition {
        case .push(let animated):
            navigationController.pushViewController(viewController, animated: animated)
        case .present(let animated, let modalPresentationStyle, let completion):
            present(viewController: viewController, animated: animated, modalPresentationStyle: modalPresentationStyle, completion: completion)
        case .none:
            throw NavigatorError.cannotShow(route)
        }
    }

    func set(routes: [Route], animated: Bool = true) {
        let views = views(for: routes)
        navigationController.setViewControllers(views, animated: animated)
    }

    func append(routes: [Route], animated: Bool = true) {
        let views = views(for: routes)
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

    private func views(for routes: [Route]) -> [UIHostingController<some View>] {
        return routes.map({ route in
            let view = self.view(for: route).ifLet(route.title) { view, value in
                view.navigationTitle(value)
            }
            return UIHostingController(rootView: view.environmentObject(self))
        })
    }

    private func present(
        viewController: UIViewController,
        animated: Bool,
        modalPresentationStyle: UIModalPresentationStyle,
        completion: (() -> Void)?
    ) {
        viewController.modalPresentationStyle = modalPresentationStyle
        navigationController.present(viewController, animated: animated, completion: completion)
    }
}
