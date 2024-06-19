import SwiftUI

public typealias TabBarRouting = Coordinator & TabBarCoordinator

/// A protocol for managing a tab bar interface in an application.
@MainActor
public protocol TabBarCoordinator: ObservableObject {
    associatedtype Route: TabBarNavigationRoute
    
    var navigationController: NavigationController { get }
    var tabBarController: UITabBarController { get }
    var tabs: [Route] { get }
    /// This method should be called to show the `tabBarController`
    func start(with action: TransitionAction)
}

public extension TabBarCoordinator where Self: RouterViewFactory {
    func start(with action: TransitionAction = .push(animated: true)) {
        tabBarController.viewControllers = views(for: tabs)
        
        switch action {
        case .push(let animated):
            navigationController.pushViewController(tabBarController, animated: animated)
        case .present(let animated, let modalPresentationStyle, let delegate, let completion):
            present(
                viewController: tabBarController,
                animated: animated,
                modalPresentationStyle: modalPresentationStyle,
                delegate: delegate,
                completion: completion
            )
        }
    }
    
    // MARK: - Private methods
    
    private func present(
        viewController: UITabBarController,
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
}
