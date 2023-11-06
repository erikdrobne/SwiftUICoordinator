//
//  SimpleShapesView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 23/03/2023.
//

import SwiftUI
import SwiftUICoordinator

struct SimpleShapesView<Coordinator: Routing>: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = ViewModel<Coordinator>()

    var body: some View {
        List {
            Button {
                viewModel.didTapRectangle()
            } label: {
                Text("Rectangle")
            }
            Button {
                viewModel.didTapRoundedRectangle()
            } label: {
                Text("RoundedRectangle")
            }
            Button {
                viewModel.didTapCapsule()
            } label: {
                Text("Capsule")
            }
            Button {
                viewModel.didTapEllipse()
            } label: {
                Text("Ellipse")
            }
            Button {
                viewModel.didTapCircle()
            } label: {
                Text("Circle")
            }
        }
        .onAppear {
            viewModel.coordinator = coordinator
        }
    }
}

extension SimpleShapesView {
    @MainActor class ViewModel<R: Routing>: ObservableObject {
        var coordinator: R?

        func didTapRectangle() {
            coordinator?.handle(SimpleShapesAction.rect)
        }

        func didTapRoundedRectangle() {
            coordinator?.handle(SimpleShapesAction.roundedRect)
        }

        func didTapCapsule() {
            coordinator?.handle(SimpleShapesAction.capsule)
        }

        func didTapEllipse() {
            coordinator?.handle(SimpleShapesAction.ellipse)
        }

        func didTapCircle() {
            coordinator?.handle(SimpleShapesAction.circle)
        }
    }
}

struct SimpleShapesView_Previews: PreviewProvider {
    static let coordinator = SimpleShapesCoordinator(
        parent: nil,
        navigationController: NavigationControllerFactory().makeNavigationController()
    )
    
    static var previews: some View {
        SimpleShapesView<SimpleShapesCoordinator>()
            .environmentObject(coordinator)
    }
}
