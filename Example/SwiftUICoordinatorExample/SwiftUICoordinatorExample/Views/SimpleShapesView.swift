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
    @MainActor class ViewModel<Coordinator: Routing>: ObservableObject {
        var coordinator: Coordinator?

        func didTapRectangle() {
            coordinator?.navigate(to: SimpleShapesRoute.rect)
        }

        func didTapRoundedRectangle() {
            coordinator?.navigate(to: SimpleShapesRoute.roundedRect)
        }

        func didTapCapsule() {
            coordinator?.navigate(to: SimpleShapesRoute.capsule)
        }

        func didTapEllipse() {
            coordinator?.navigate(to: SimpleShapesRoute.ellipse)
        }

        func didTapCircle() {
            coordinator?.navigate(to: SimpleShapesRoute.circle)
        }
    }
}

struct SimpleShapesView_Previews: PreviewProvider {
    static let coordinator = SimpleShapesCoordinator(parent: nil, navigationController: .init())
    
    static var previews: some View {
        SimpleShapesView<SimpleShapesCoordinator>()
            .environmentObject(coordinator)
    }
}
