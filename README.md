# SwiftUICoordinator

## Introduction

The Coordinator pattern is a widely used design pattern in Swift/iOS applications that facilitates the management of navigation and view flow within an app. The main idea behind this pattern is to decouple the navigation logic from the views, thereby making it easier to maintain and extend the application over time. By offering a central point of contact for navigation purposes, the Coordinator pattern encapsulates the navigation logic and enables views to remain lightweight and focused on their own responsibilities.

This package provides a seamless integration of the Coordinator pattern into the SwiftUI framework, making it easy to implement and manage navigation in your SwiftUI applications. With the Coordinator pattern, you can easily manage the flow of views within your app, while maintaining a clear separation of concerns between views and navigation logic. This results in a more maintainable and extensible app, with clean and easy-to-understand code.

## Problem

Despite the benefits of using SwiftUI, navigating between views and managing their flow can become a complex and cumbersome task. With `NavigationStack`, there are limitations where dismissing or replacing views in the middle of the stack becomes challenging. This can occur when you have multiple views that are presented in sequence, and you need to dismiss or replace one of the intermediate views.

The second challenge is related to popping to the root view. This can occur when you have multiple views that are presented in a hierarchical manner, and you need to return to the root view.

## Implementation

### Coordinator

Coordinator protocol is the main component that all our coordinators will conform to.

**Properties**

```Swift
/// An optional property to store parent's reference.
var parent: Coordinator? { get }
/// An array to store any child coordinators.
var childCoordinators: [Coordinator] { get set }
```

**Methods**

```Swift
/// Tell the coordinator that the flow is finished.
func finish()
/// Add a child coordinator.
func add(child: Coordinator)
```

### NavigationRoute

Available routes for navigation.

**Properties**

```Swift
var title: String? { get }
/// Transition type.
var transition: NavigationTransition? { get }
```

### NavigationTransition

An enum that holds the available transition styles.

```Swift
case push(...
case present(animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle = .automatic, ...
```

### Navigator

The Navigator protocol encapsulates all the necessary logic for navigating hierarchical content, including the management of the UINavigationController and its child views.

**Properties**

```Swift
/// A reference to the UINavigationController.
var navigationController: UINavigationController { get set }
var startRoute: Route? { get }
```

**Methods**

```Swift
/// Start the flow.
func start()
/// Flow navigation.
func show(route: Route)
func set(routes: [Route], animated: Bool)
func append(routes: [Route], animated: Bool)
func pop(animated: Bool)
func popToRoot(animated: Bool)
func dismiss(animated: Bool)
```

## Installation

### Requirements

**iOS 15.0** or higher

### Swift Package Manager

```Swift
dependencies: [
    .package(url: "https://github.com/erikdrobne/SwiftUICoordinator")
]
```

## Usage

```Swift
import SwiftUICoordinator
```

### Create Route

```Swift
enum ShapesRoute: NavigationRoute {
    case shapes
    case simpleShapes
    case customShapes
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

### Create ShapesCoordinatorNavigation protocol

```Swift
protocol ShapesCoordinatorNavigation {
    func didTap(route: ShapesRoute)
}
```

### Conform to RouterViewFactory

```Swift
extension ShapesCoordinator: RouterViewFactory {
    @ViewBuilder
    public func view(for route: ShapesRoute) -> some View {
        switch route {
        case .shapes:
            ShapesView()
        case .simpleShapes:
            /// We are returning an empty view for the route presenting a child coordinator.
            EmptyView()
        case .customShapes:
            CustomShapesView()
        case .featuredShape:
            EmptyView()
        }
    }
}
```

### Create Coordinator

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

    func presentRoot() {
        popToRoot()
        childCoordinators.removeAll()
    }
}

extension ShapesCoordinator: ShapesCoordinatorNavigation {
    func didTap(route: ShapesRoute) {
        switch route {
        case .simpleShapes:
            let coordinator = makeSimpleShapesCoordinator()
            coordinator.start()
        case .customShapes:
            let coordinator = makeCustomShapesCoordinator()
            coordinator.start()
        case .featuredShape(let route):
            ...
        default:
            show(route: route)
        }
    }
```

## Initialize ShapesCoordinator

We are going to create an instance of ShapesCoordinator (our root coordinator) and pass it's `UINavigationController` to the
`UIWindow`.

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

## Usage in the Views

```Swift
import SwiftUICoordinator

struct ShapesView: View {

    @EnvironmentObject var coordinator: ShapesCoordinator

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

## Example project

Example project is attached to the repo. It can be found in the SwiftUICoordinatorExample folder.
