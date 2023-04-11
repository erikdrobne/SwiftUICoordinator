# SwiftUICoordinator

https://github.com/erikdrobne/SwiftUICoordinator/actions/workflows/workflow.yml/badge.svg

## Introduction

The Coordinator pattern is a widely used design pattern in Swift/iOS applications that facilitates the management of navigation and view flow within an app. The main idea behind this pattern is to decouple the navigation logic from the views, thereby making it easier to maintain and extend the application over time. By offering a central point of contact for navigation purposes, the Coordinator pattern encapsulates the navigation logic and enables views to remain lightweight and focused on their own responsibilities.

This package provides a seamless integration of the Coordinator pattern into the SwiftUI framework, making it easy to implement and manage navigation in your SwiftUI applications. With the Coordinator pattern, you can easily manage the flow of views within your app, while maintaining a clear separation of concerns between views and navigation logic. This results in a more maintainable and extensible app, with clean and easy-to-understand code.

## 💡 Problem

Despite the benefits of using SwiftUI, navigating between views and managing their flow can become a complex and cumbersome task. With `NavigationStack`, there are limitations where dismissing or replacing views in the middle of the stack becomes challenging. This can occur when you have multiple views that are presented in sequence, and you need to dismiss or replace one of the intermediate views.

The second challenge is related to popping to the root view. This can occur when you have multiple views that are presented in a hierarchical manner, and you need to return to the root view.

## 🏃 Implementation

<img width="500" alt="coordinator-diagram" src="https://user-images.githubusercontent.com/15943419/229084345-bb7ff093-b267-4b8e-ac12-a206bdd427c9.png">

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
    
    /// Adds a child coordinator to the coordinator's child coordinators list, if needed.
    func add(child: Coordinator)
    /// Navigate to a specific route.
    func navigate(to route: NavigationRoute)
    /// Remove the coordinator from its parent's child coordinators list.
    func finish()
}
```

### NavigationRoute

This protocol defines the available routes for navigation within a coordinator flow, which should be implemented using enum types.

**Protocol declaration**

```Swift
public protocol NavigationRoute {
    /// This title can be used to set the navigation bar title when the route is shown.
    var title: String? { get }
    /// The type of transition to be used when the route is shown. 
    /// This can be a push transition, a modal presentation, or `nil` (for child coordinators).
    var transition: NavigationTransition? { get }
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
    
    var navigationController: UINavigationController { get set }
    /// The starting route of the navigator.
    var startRoute: Route? { get }
    
    /// This method is called when the navigator should start navigating.
    func start()
    /// Navigate to a specific route. 
    /// It creates a view for the route and adds it to the navigation stack using the specified transition.
    func show(route: Route)
    /// Sets the navigation stack to a new array of routes.
    /// It can be useful if you need to reset the entire navigation stack to a new set of views.
    func set(routes: [Route], animated: Bool)
    /// Append a new set of routes to the existing navigation stack.
    func append(routes: [Route], animated: Bool)
    /// Pop the current view from the navigation stack.
    func pop(animated: Bool)
    /// Pops all the views from the stack except the root view.
    func popToRoot(animated: Bool)
    /// Dismiss the view that was presented modally.
    func dismiss(animated: Bool)
    /// Presents the root view.
    func presentRoot()
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
In the following example, we have the `ShapesRoute` enum representing the main flows of our application. It offers routes to present shapes list, simple shapes list, custom shapes list and
a featured shape.

We can also create a deep link by creating an enum case with the associated value of type `NavigationRoute` and handle
flow execution within the coordinator.

```Swift
enum ShapesRoute: NavigationRoute {
    case shapes
    case simpleShapes
    case customShapes
    /// Deep link
    case featuredShape(NavigationRoute)

    var title: String? {
        switch self {
        case .shapes:
            return "SwiftUI Shapes"
        default:
            return nil
        }
    }

    var transition: NavigationTransition? {
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

### Create Coordinator

Our `ShapesCoordinator` has to conform to the `Navigator` protocol and implement the `navigate(to route: NavigationRoute)` to execute flow-specific logic on method execution. Root coordinator has to initialize `UINavigationController`.

```Swift
class ShapesCoordinator: NSObject, Coordinator, Navigator {

    // MARK: - Internal properties

    /// Root coordinator doesn't have a parent.
    weak var parent: Coordinator? = nil
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let startRoute: ShapesRoute?

    // MARK: - Initialization

    init(navigationController: UINavigationController = .init(), startRoute: ShapesRoute? = nil) {
        self.navigationController = navigationController
        self.startRoute = startRoute
        super.init()
    }
    
    func navigate(to route: NavigationRoute) {
        switch route {
        case ShapesRoute.simpleShapes:
            let coordinator = makeSimpleShapesCoordinator()
            coordinator.start()
        case ShapesRoute.customShapes:
            let coordinator = makeCustomShapesCoordinator()
            coordinator.start()
        case ShapesRoute.featuredShape(let route):
            switch route {
            case let shapeRoute as SimpleShapesRoute:
                let coordinator = makeSimpleShapesCoordinator()
                coordinator.append(routes: [.simpleShapes, shapeRoute])
            case let shapeRoute as CustomShapesRoute:
                let coordinator = makeCustomShapesCoordinator()
                coordinator.append(routes: [.customShapes, shapeRoute])
            default:
                return
            }
        default:
            return
        }
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

We are going to create an instance of `ShapesCoordinator` (our root coordinator) and pass it's `UINavigationController` to the
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

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let coordinator = ShapesCoordinator(startRoute: .shapes)
        window = UIWindow(windowScene: windowScene)
        /// Assign root coordinator's navigation controller
        window?.rootViewController = coordinator.navigationController
        window?.makeKeyAndVisible()

        coordinator.start()
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

    var body: some View {
        List {
            Button {
                coordinator?.didTap(route: .simpleShapes)
            } label: {
                Text("Built-in")
            }
        }
    }
}
```

## 📒 Example project

For better understanding, I recommend that you take a look at the example project located in the `SwiftUICoordinatorExample` folder.
