//
//  SimpleShapesView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 23/03/2023.
//

import SwiftUI

struct SimpleShapesView: View {

    @EnvironmentObject var coordinator: SimpleShapesCoordinator
    @StateObject var viewModel = ViewModel()

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
    @MainActor class ViewModel: ObservableObject {
        var coordinator: SimpleShapesCoordinator?

        func didTapRectangle() {
            coordinator?.didTap(route: .rect)
        }

        func didTapRoundedRectangle() {
            coordinator?.didTap(route: .roundedRect)
        }

        func didTapCapsule() {
            coordinator?.didTap(route: .capsule)
        }

        func didTapEllipse() {
            coordinator?.didTap(route: .ellipse)
        }

        func didTapCircle() {
            coordinator?.didTap(route: .circle)
        }
    }
}

struct SimpleShapesView_Previews: PreviewProvider {
    static var previews: some View {
        SimpleShapesView()
    }
}
