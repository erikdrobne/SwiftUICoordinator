# SwiftUICoordinator

## Introduction

The Coordinator pattern is a popular design pattern in Swift/iOS apps that assists in managing navigation and flow between views within an application. The concept involves keeping views lightweight and decoupled, resulting in an app that is easier to maintain and extend over time. This package offers a solution for seamlessly integrating the Coordinator pattern into the SwiftUI framework.

## Problem

Despite the benefits of using SwiftUI, navigating between views and managing their flow can become a complex and cumbersome task. With NavigationStack, there are limitations where dismissing or replacing views in the middle of the stack becomes challenging. Additionally, views within an app should be decoupled from each other and should not know about the configuration or presentation of other views. Our goal is to reduce the time spent on navigation by seamlessly integrating the Coordinator pattern into SwiftUI, providing a lightweight and decoupled approach to view management that enables efficient dismissal and replacement of views.

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
```

Flow navigation.

```Swift
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
