# SwiftUICoordinator

![Build Status](https://github.com/erikdrobne/SwiftUICoordinator/actions/workflows/workflow.yml/badge.svg)

## Introduction

The Coordinator pattern is a widely used design pattern in Swift/iOS applications that facilitates the management of navigation and view flow within an app. The main idea behind this pattern is to decouple the navigation logic from the views, thereby making it easier to maintain and extend the application over time. By offering a central point of contact for navigation purposes, the Coordinator pattern encapsulates the navigation logic and enables views to remain lightweight and focused on their own responsibilities.

This package provides a seamless integration of the Coordinator pattern into the SwiftUI framework, making it easy to implement and manage navigation in your SwiftUI applications. With the Coordinator pattern, you can easily manage the flow of views within your app, while maintaining a clear separation of concerns between views and navigation logic. This results in a more maintainable and extensible app, with clean and easy-to-understand code.

## 💡 Problem

Despite the benefits of using SwiftUI, navigating between views and managing their flow can become a complex and cumbersome task. With `NavigationStack`, there are limitations where dismissing or replacing views in the middle of the stack becomes challenging. This can occur when you have multiple views that are presented in sequence, and you need to dismiss or replace one of the intermediate views.

The second challenge is related to popping to the root view. This can occur when you have multiple views that are presented in a hierarchical manner, and you need to return to the root view.

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
}
```

### CoordinatorAction

This protocol defines the available actions for the coordinator. Views should only communicate with the coordinator using actions (unidirectional flow). 

**Protocol declaration**

```Swift
public protocol CoordinatorAction {}

/// Essential actions.
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
    /// Navigation bar title.
    var title: String? { get }
    /// Transition action to be used when the route is shown.
    /// This can be a push action, a modal presentation, or `nil` (for child coordinators).
    var action: TransitionAction? { get }
}
```

### Navigator

The Navigator protocol encapsulates all the necessary logic for navigating hierarchical content, including the management of the `UINavigationController` and its child views.

**Protocol declaration**

```Swift

public typealias Routing = Coordinator & Navigator

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

First, create an enum with all the available routes for a particular flow.
In the following example, we have the `ShapesRoute` enum representing the main flows of our application. It offers routes to present shapes list, simple shapes list, custom shapes list and a featured shape.

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
            return .push()
        }
    }
}
```

### Create Action

`ShapesAction` represents all the available actions that can be triggered by the view.

```Swift
enum ShapesAction: CoordinatorAction {
    case simpleShapes
    case customShapes
    /// Deep link
    case featuredShape(NavigationRoute)
}
```

We can also make a deep link by adding an associated value of type `NavigationRoute` to the enum.

### Create Coordinator

Our `ShapesCoordinator` has to conform to the `Routing` protocol and implement the `handle(_ action: CoordinatorAction)` method which executes flow-specific logic when the action is received. `ShapesCoordinator` is the root coordinator and therefore needs to initialize `NavigationController`.

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
            case let shapeRoute as SimpleShapesRoute where shapeRoute != .simpleShapes:
                let coordinator = makeSimpleShapesCoordinator()
                coordinator.append(routes: [.simpleShapes, shapeRoute])
            case let shapeRoute as CustomShapesRoute where shapeRoute != .customShapes:
                let coordinator = makeCustomShapesCoordinator()
                coordinator.append(routes: [.customShapes, shapeRoute])
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

By conforming to the `RouterViewFactory` protocol, we are defining which view should be displayed for each route. If we need to present a child coordinator, we will return an `EmptyView`.  

```Swift
extension ShapesCoordinator: RouterViewFactory {
    @ViewBuilder
    public func view(for route: ShapesRoute) -> some View {
        switch route {
        case .shapes:
            ShapesView<ShapesCoordinator>()
        case .simpleShapes:
            /// We are returning an empty view for the route presenting a child coordinator.
            EmptyView()
        case .customShapes:
            CustomShapesView<CustomShapesCoordinator>()
        case .featuredShape:
            EmptyView()
        }
    }
}
```

### Initialize ShapesCoordinator

We are going to create an instance of `ShapesCoordinator` (our root coordinator) and pass its `UINavigationController` to the
`UIWindow`. Our start route for the coordinator is `ShapesRoute.shape`.

```Swift
import SwiftUI

@main
struct SwiftUICoordinatorExampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {

        }
    }
}

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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}
```

### Usage in the Views

The coordinator is accessible within a SwiftUI view through an `@EnvironmentObject`.

```Swift
import SwiftUICoordinator

struct ShapesView<Coordinator: Routing>: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = ViewModel<Coordinator>()

    var body: some View {
        List {
            Button {
                viewModel.didTapBuiltIn()
            } label: {
                Text("Built-in")
            }
        }
        .onAppear {
            viewModel.coordinator = coordinator
        }
    }
}
```

### Custom transitions

Create custom Fade transition.

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

Register transition in the coordinator initializer.

```Swift
    init(startRoute: ShapesRoute? = nil) {
        self.navigationController = NavigationController()
        self.startRoute = startRoute
        super.init()
        
        navigationController.register(FadeTransition())
    }
```

## 📒 Example project

For better understanding, I recommend that you take a look at the example project located in the `SwiftUICoordinatorExample` folder.
