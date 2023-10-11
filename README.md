# SwiftUICoordinator

![Build Status](https://github.com/erikdrobne/SwiftUICoordinator/actions/workflows/workflow.yml/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://github.com/erikdrobne/SwiftUICoordinator/blob/main/LICENSE.md)
![Static Badge](https://img.shields.io/badge/iOS%20Compatibility-15.0-blue)

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
    /// Should be used as a weak reference.
    var parent: Coordinator? { get }
    /// An array that stores references to any child coordinators.
    var childCoordinators: [WeakCoordinator] { get set }
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

public enum Action: CoordinatorAction {
    case done(Any)
    case cancel(Any)
}
```

### NavigationRoute

This protocol defines the available routes for navigation within a coordinator flow.

**Protocol declaration**

```Swift
@MainActor
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

The coordinator has to conform to the `Routing` protocol and implement the `handle(_ action: CoordinatorAction)` method which executes flow-specific logic when the action is received.
```Swift
class ShapesCoordinator: Routing {

    // MARK: - Internal properties

    weak var parent: Coordinator?
    var childCoordinators = [WeakCoordinator]()
    let navigationController: NavigationController
    let startRoute: ShapesRoute
    let factory: CoordinatorFactory

    // MARK: - Initialization

    init(
        parent: Coordinator?,
        navigationController: NavigationController,
        startRoute: ShapesRoute = .shapes,
        factory: CoordinatorFactory
    ) {
        self.parent = parent
        self.navigationController = navigationController
        self.startRoute = startRoute
        self.factory = factory
    }
    
    func handle(_ action: CoordinatorAction) {
        switch action {
        case ShapesAction.simpleShapes:
            let coordinator = factory.makeSimpleShapesCoordinator(parent: self)
            try? coordinator.start()
        case ShapesAction.customShapes:
            let coordinator = factory.makeCustomShapesCoordinator(parent: self)
            try? coordinator.start()
        case let ShapesAction.featuredShape(route):
            switch route {
            ...
            default:
                return
            }
        case Action.done(_):
            popToRoot()
            childCoordinators.removeAll()
        default:
            parent?.handle(action)
        }
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
            ShapeListView<ShapesCoordinator>()
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

### Adding RootCoordinator to the app

We will instantiate `AppCoordinator` (a subclass of `RootCoordinator`), pass `ShapesCoordinator` as its child, and then initiate the flow. 
Our starting route will be `ShapesRoute.shapes`.

```Swift

final class SceneDelegate: NSObject, UIWindowSceneDelegate {

    var dependencyContainer = DependencyContainer()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let window = (scene as? UIWindowScene)?.windows.first else {
            return
        }

        let appCoordinator = dependencyContainer.makeAppCoordinator(window: window)
        dependencyContainer.set(appCoordinator)
        
        let coordinator = dependencyContainer.makeShapesCoordinator(parent: appCoordinator)
        appCoordinator.start(with: coordinator)
    }
}
```

### Access coordinator in SwiftUI view

The coordinator is by default attached to the SwiftUI as an `@EnvironmentObject`.
To disable this feature, you need to set the `attachCoordinator` property of the `NavigationRoute` to `false`.

```Swift
import SwiftUICoordinator

struct ShapeListView<Coordinator: Routing>: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = ViewModel<Coordinator>()

    var body: some View {
        List {
            Button {
                viewModel.didTapBuiltIn()
            } label: {
                Text("Simple")
            }
            Button {
                viewModel.didTapCustom()
            } label: {
                Text("Custom")
            }
            Button {
                viewModel.didTapFeatured()
            } label: {
                Text("Featured")
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

Transitions will be registered within the `RootCoordinator` initializer by passing them as parameters.

```Swift
@MainActor
open class RootCoordinator: Coordinator {
    
    /// RootCoordinator doesn't have a parent
    public let parent: Coordinator? = nil
    public var childCoordinators = [WeakCoordinator]()
    private let transitions: [Transition]
    
    public private(set) var window: UIWindow
    public private(set) var navigationController: NavigationController
    
    public init(window: UIWindow, navigationController: NavigationController, transitions: [Transition] = []) {
        self.window = window
        self.navigationController = navigationController
        self.transitions = transitions
        
        navigationController.register(transitions)
        window.rootViewController = self.navigationController
        window.makeKeyAndVisible()
    }
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

**If you appreciate this project, kindly give it a ⭐️ to help others discover the repository.**
