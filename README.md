# SwiftUICoordinator

![Build Status](https://github.com/erikdrobne/SwiftUICoordinator/actions/workflows/workflow.yml/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/erikdrobne/SwiftUICoordinator/blob/main/LICENSE.md)

## Introduction

The Coordinator pattern is a widely used design pattern in Swift/iOS applications that facilitates the management of navigation and view flow within an app. The main idea behind this pattern is to decouple the navigation logic from the views, thereby making it easier to maintain and extend the application over time. By offering a central point of contact for navigation purposes, the Coordinator pattern encapsulates the navigation logic and enables views to remain lightweight and focused on their own responsibilities.

This package provides a seamless integration of the Coordinator pattern into the SwiftUI framework, making it easy to implement and manage navigation in your SwiftUI applications. With the Coordinator pattern, you can easily manage the flow of views within your app, while maintaining a clear separation of concerns between views and navigation logic. This results in a more maintainable and extensible app, with clean and easy-to-understand code.

## 💡 Problem

Despite the benefits of using SwiftUI, navigating between views and managing their flow can become a complex and cumbersome task. With `NavigationStack`, there are limitations where dismissing or replacing views in the middle of the stack becomes challenging. This can occur when you have multiple views that are presented in sequence, and you need to dismiss or replace one of the intermediate views.

The second challenge is related to popping to the root view when you have several views presented in a hierarchical manner, and you want to return to the root view.

## 🏃 Implementation

<img width="912" alt="workflow" src="https://github.com/erikdrobne/SwiftUICoordinator/assets/15943419/9c9d279c-e87d-43c2-85df-7f197bed01d3">

### Coordinator

Coordinator protocol is the core component of the pattern representing each distinct flow of views in your app.

**Protocol declaration**

```Swift
@MainActor
public protocol Coordinator: AnyObject {
    /// A property that stores a reference to the parent coordinator, if any.
    var parent: Coordinator? { get }
    /// An array that stores references to any child coordinators.
    var childCoordinators: [Coordinator] { get set }
    
    /// Takes action parameter and handles the `CoordinatorAction`.
    func handle(_ action: CoordinatorAction)
    /// Adds child coordinator to the list.
    func add(child: Coordinator)
    /// Removes the coordinator from the list of children.
    func remove(coordinator: Coordinator)
    /// Takes deep link and its parameters and handles it.
    func handle(_ deepLink: DeepLink, with params: [String: String])
}
```

### CoordinatorAction

This protocol defines the available actions for the coordinator. Views should exclusively interact with the coordinator through actions, ensuring a unidirectional flow of communication.

**Protocol declaration**

```Swift
public protocol CoordinatorAction {}

/// Essential actions that can be performed by coordinators.
public enum Action: CoordinatorAction {
    case done(Any)
    case cancel(Any)
}
```

### NavigationRoute

This protocol defines the available routes for navigation within a coordinator flow.

**Protocol declaration**

```Swift
public protocol NavigationRoute {
    /// Use this title to set the navigation bar title when the route is displayed.
    var title: String? { get }
    /// A property that provides the info about the appearance and styling of a route in the navigation system.
    var appearance: RouteAppearance? { get }
    /// Transition action to be used when the route is shown.
    /// This can be a push action, a modal presentation, or `nil` (for child coordinators).
    var action: TransitionAction? { get }
    /// A property that indicates whether the Coordinator should be attached to the View as an EnvironmentObject.
    var attachCoordinator: Bool { get }
}
```

### Navigator

The Navigator protocol encapsulates all the necessary logic for navigating hierarchical content, including the management of the `NavigationController` and its child views.

**Protocol declaration**

```Swift
@MainActor
public protocol Navigator: ObservableObject {
    associatedtype Route: NavigationRoute

    var navigationController: NavigationController { get }
    /// The starting route of the navigator.
    var startRoute: Route { get }
    
    /// This method should be called to start the flow  and to show the view for the `startRoute`.
    func start() throws
    /// It creates a view for the route and adds it to the navigation stack.
    func show(route: Route) throws
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
```

## 💿 Installation

### Requirements

`iOS 15.0` or higher

### Swift Package Manager

```Swift
dependencies: [
    .package(url: "https://github.com/erikdrobne/SwiftUICoordinator")
]
```

## 🔧 Usage

```Swift
import SwiftUICoordinator
```

### Create Route

Start by creating an enum with all the available routes for a particular coordinator flow.

```Swift
enum ShapesRoute: NavigationRoute {
    case shapes
    case simpleShapes
    case customShapes
    case featuredShape

    var title: String? {
        switch self {
        case .shapes:
            return "SwiftUI Shapes"
        default:
            return nil
        }
    }

    var action: TransitionAction? {
        switch self {
        case .simpleShapes:
            // We have to pass nil for the route presenting a child coordinator.
            return nil
        default:
            return .push(animated: true)
        }
    }
}
```

### Create Action

Specify custom actions that can be sent from coordinated objects to their parent coordinators.

```Swift
enum ShapesAction: CoordinatorAction {
    case simpleShapes
    case customShapes
    case featuredShape(NavigationRoute)
}
```

### Create Coordinator

The coordinator has to conform to the `Routing` protocol and implement the `handle(_ action: CoordinatorAction)` method which executes flow-specific logic when the action is received. `ShapesCoordinator` is the root coordinator in the example and therefore needs to initialize `NavigationController`.

```Swift
class ShapesCoordinator: Routing {

    // MARK: - Internal properties

    /// Root coordinator doesn't have a parent.
    let parent: Coordinator? = nil
    var childCoordinators = [Coordinator]()
    var navigationController: NavigationController
    let startRoute: ShapesRoute

    // MARK: - Initialization

    init(startRoute: ShapesRoute) {
        self.navigationController = NavigationController()
        self.startRoute = startRoute
        
        setup()
    }
    
    func handle(_ action: CoordinatorAction) {
        switch action {
        case ShapesAction.simpleShapes:
            let coordinator = makeSimpleShapesCoordinator()
            try? coordinator.start()
        case ShapesAction.customShapes:
            let coordinator = makeCustomShapesCoordinator()
            try? coordinator.start()
        case let ShapesAction.featuredShape(route):
            switch route {
            ...
            default:
                return
            }
        default:
            break
        }
    }
    
    // MARK: - Private methods
    
    private func setup() {
        navigationController.register(FadeTransition())
    }
}
```

### Conform to RouterViewFactory

By conforming to the `RouterViewFactory` protocol, we are defining which view should be displayed for each route. 
**Important: When we want to display a child coordinator, we should return an EmptyView.**

```Swift
extension ShapesCoordinator: RouterViewFactory {
    @ViewBuilder
    public func view(for route: ShapesRoute) -> some View {
        switch route {
        case .shapes:
            ShapesView<ShapesCoordinator>()
        case .simpleShapes:
            EmptyView()
        case .customShapes:
            CustomShapesView<CustomShapesCoordinator>()
        case .featuredShape:
            EmptyView()
        }
    }
}
```

### Adding root coordinator to the app

We are going instantiate `ShapesCoordinator` (our root coordinator) and pass its `UINavigationController` to the
`UIWindow`. Our start route for the coordinator is `ShapesRoute.shape`.

```Swift

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let window = (scene as? UIWindowScene)?.windows.first else {
            return
        }

        let coordinator = ShapesCoordinator(startRoute: .shapes)
        /// Assign root coordinator's navigation controller
        window.rootViewController = coordinator.navigationController
        window.makeKeyAndVisible()

        try? coordinator.start()
    }
}
```

### Access coordinator in SwiftUI view

The coordinator is by default attached to the SwiftUI as an `@EnvironmentObject`.
To disable this feature, you need to set the `attachCoordinator` property of the `NavigationRoute` to `false`.

```Swift
import SwiftUICoordinator

struct ShapesView<Coordinator: Routing>: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = ViewModel<Coordinator>()

    var body: some View {
        List {
            Button {
                viewModel.handleButtonTap()
            } label: {
                Text("Button")
            }
        }
        .onAppear {
            viewModel.coordinator = coordinator
        }
    }
}
```

### Custom transitions

SwiftUICoordinator also supports creating custom transitions.

```Swift
class FadeTransition: NSObject, Transition {
    func isEligible(from fromRoute: NavigationRoute, to toRoute: NavigationRoute, operation: NavigationOperation) -> Bool {
        return (fromRoute as? CustomShapesRoute == .customShapes && toRoute as? CustomShapesRoute == .star)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        
        let containerView = transitionContext.containerView
        toView.alpha = 0.0
        
        containerView.addSubview(toView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toView.alpha = 1.0
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
```

Register transition.

```Swift
navigationController.register(FadeTransition())
```

### Handling deep links

In your application, you can handle deep links by creating a `DeepLinkHandler` that conforms to the `DeepLinkHandling` protocol. This handler will specify the URL scheme and the supported deep links that your app can recognize.

```Swift
class DeepLinkHandler: DeepLinkHandling {
    static let shared = DeepLinkHandler()
    
    let scheme = "coordinatorexample"
    let links: Set<DeepLink> = [
        DeepLink(action: "custom", route: ShapesRoute.customShapes)
    ]
    
    private init() {}
}
```

To handle incoming deep links in your app, you can implement the `scene(_:openURLContexts:)` method in your scene delegate.

```Swift
func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let url = URLContexts.first?.url {
        // Attempt to retrieve the deep link and its associated parameters.
        guard 
            let deepLink = try? dependencyContainer.deepLinkHandler.link(for: url),
            let params = try? dependencyContainer.deepLinkHandler.params(for: url, and: deepLink.params)
        else {
            return
        }
        
        // Handle the deep link and its parameters using your coordinator.
        coordinator.handle(deepLink, with: params)
    }
}
```


## 📒 Example project

For better understanding, I recommend that you take a look at the example project located in the `SwiftUICoordinatorExample` folder.

## 🤝 Contributions:

Contributions are welcome! 
If you find any issues, have suggestions for improvements, or want to add features, please open an issue or submit a pull request.
