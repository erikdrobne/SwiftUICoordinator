//
//  ShapeListView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 08/03/2023.
//

import SwiftUI
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
            Button {
                viewModel.didTapTabs()
            } label: {
                Text("Tabs")
            }
        }
        .onAppear {
            viewModel.coordinator = coordinator
        }
    }
}

extension ShapeListView {
    @MainActor class ViewModel<R: Routing>: ObservableObject {
        var coordinator: R?

        func didTapBuiltIn() {
            coordinator?.handle(ShapesAction.simpleShapes)
        }

        func didTapCustom() {
            coordinator?.handle(ShapesAction.customShapes)
        }

        func didTapFeatured() {
            let routes: [NavigationRoute] = [
                SimpleShapesRoute.circle,
                CustomShapesRoute.tower,
                SimpleShapesRoute.capsule
            ]

            guard let route = routes.randomElement() else {
                return
            }

            coordinator?.handle(ShapesAction.featuredShape(route))
        }

        func didTapTabs() {
            coordinator?.handle(ShapesAction.tabs)
        }
    }
}

struct ShapesView_Previews: PreviewProvider {
    static let coordinator = ShapesCoordinator(
        parent: nil,
        navigationController: NavigationControllerFactory().makeNavigationController(),
        startRoute: ShapesRoute.shapes,
        factory: DependencyContainer.mock
    )

    static var previews: some View {
        ShapeListView<ShapesCoordinator>()
            .environmentObject(coordinator)
    }
}
