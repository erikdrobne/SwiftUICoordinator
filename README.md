# SwiftUICoordinator

Coordinator pattern is a design pattern commonly used in Swift/iOS apps that helps you manage navigation and flow between views in your application.
The idea is to keep views lightweight, decoupled and the app easier to maintain and extend over time.
This package represents a solution for integrating Coordinator pattern into the SwiftUI framework.

## Problem

In SwiftUI with NavigationStack we miss dismissing in the middle of the stack or replacing the view.
UINavigationController works from earlier versions of iOS while NavigationStack was introduced with iOS 16.0.
Our views shouldn’t know about configuration and presentation of other views.

## Implementation

### Coordinator

Coordinator protocol is the main component that all our coordinators will conform to.

**Properties**

An optional property to store parent's reference.

`var parent: Coordinator? { get }`
 
An array to store any child coordinators.

`var childCoordinators: [Coordinator] { get set }`

**Methods**

A method to tell the coordinator that it should finish the flow.

`func finish()`

A method to add a child coordinator.

`func add(child: Coordinator)`

### NavigationRoute

Available routes (where coordinator can transition to) are represented by NavigationRoute protocol.

**Properties**

Route title.

`var title: String? { get }`

Transition type.

`var transition: NavigationTransition? { get }`

### NavigationTransition

An enum that hold the available transition styles.

`case push(...`

`case present(animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle = .automatic, ...`

### Navigator

Navigator protocol encapsulates all logic for navigating hierarchical content. It manages `UINavigationController`
it’s child views.

**Properties**

A reference to the `UINavigationController`.

`var navigationController: UINavigationController { get set }`

`var startRoute: Route? { get }`

**Methods**

A method to start the flow.

`func start()`

Methods for flow navigation.

```
func show(route: Route)
func set(routes: [Route], animated: Bool)
func append(routes: [Route], animated: Bool)
func pop(animated: Bool)
func popToRoot(animated: Bool)
func dismiss(animated: Bool)
```

## Usage

## Examples
