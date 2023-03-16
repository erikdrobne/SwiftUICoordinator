//
//  SquareView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 10/03/2023.
//

import SwiftUI

struct SquareView: View {

    @EnvironmentObject var coordinator: SquaresCoordinator
    @StateObject var viewModel = ViewModel()

    let color: Color

    var body: some View {
        VStack {
            Text("Square")
                .font(.title)
                .fontWeight(.bold)
            Spacer()
            Rectangle()
                .aspectRatio(1.0, contentMode: .fit)
                .foregroundColor(color)

            Spacer()

            HStack {
                Button {
                    viewModel.done()
                } label: {
                    Text("Done")
                }
                .buttonStyle(.borderedProminent)
                Button {
                    viewModel.didTapDetails()
                } label: {
                    Text("Details")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            viewModel.coordinator = coordinator
        }
    }
}

extension SquareView {
    @MainActor class ViewModel: ObservableObject {
        var coordinator: SquaresCoordinator?

        private let detailsText = """
        In Euclidean geometry, a square is a regular quadrilateral, which means that it has four equal sides and four equal angles (90-degree angles, π/2 radian angles, or right angles). It can also be defined as a rectangle with two equal-length adjacent sides. It is the only regular polygon whose internal angle, central angle, and external angle are all equal (90°), and whose diagonals are all equal in length. A square with vertices ABCD would be denoted.
        """

        func didTapDetails() {
            coordinator?.didTap(route: .details(title: "Square", text: detailsText))
        }

        func done() {
            coordinator?.presentRoot()
        }
    }
}


struct SquareView_Previews: PreviewProvider {
    static let coordinator = SquaresCoordinator(parent: nil)

    static var previews: some View {
        SquareView(color: .blue)
            .environmentObject(coordinator)
    }
}
