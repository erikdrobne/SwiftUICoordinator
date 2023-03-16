//
//  ShapesView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 08/03/2023.
//

import SwiftUI

struct ShapesView: View {

    @EnvironmentObject var coordinator: ShapesCoordinator
    @StateObject var viewModel = ViewModel()

    var body: some View {
        List {
            Section("Shapes") {
                Button {
                    viewModel.didTapCircle()
                } label: {
                    Text("Circle")
                }

                Button {
                    viewModel.didTapRectangle()
                } label: {
                    Text("Rectangle")
                }

                Button {
                    viewModel.didTapSquare()
                } label: {
                    Text("Square")
                }
            }
        }
        .onAppear {
            viewModel.coordinator = coordinator
        }
    }
}

extension ShapesView {
    @MainActor class ViewModel: ObservableObject {
        var coordinator: ShapesCoordinator?

        func didTapCircle() {
            coordinator?.didTap(route: .circle)
        }

        func didTapRectangle() {
            coordinator?.didTap(route: .rectangle)
        }

        func didTapSquare() {
            coordinator?.didTap(route: .square)
        }
    }
}

struct ShapesView_Previews: PreviewProvider {
    static var previews: some View {
        ShapesView()
    }
}
