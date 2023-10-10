//
//  ShapesView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 08/03/2023.
//

import SwiftUI
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

extension ShapesView {
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
    }
}

struct ShapesView_Previews: PreviewProvider {
    static let coordinator = ShapesCoordinator(
        parent: nil,
        navigationController: NavigationController(),
        startRoute: ShapesRoute.shapes
    )

    static var previews: some View {
        ShapesView<ShapesCoordinator>()
            .environmentObject(coordinator)
    }
}
