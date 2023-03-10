//
//  SquareView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 10/03/2023.
//

import SwiftUI

struct SquareView: View {

    @EnvironmentObject var coordinator: SquaresCoordinator

    let color: Color
    let isConfigurable: Bool

    private let detailsText = """
    In Euclidean geometry, a square is a regular quadrilateral, which means that it has four equal sides and four equal angles (90-degree angles, π/2 radian angles, or right angles). It can also be defined as a rectangle with two equal-length adjacent sides. It is the only regular polygon whose internal angle, central angle, and external angle are all equal (90°), and whose diagonals are all equal in length. A square with vertices ABCD would be denoted.
    """

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
                    coordinator.presentRoot()
                } label: {
                    Text("Present root")
                }
                .buttonStyle(.borderedProminent)
                Button {
                    coordinator.didTap(route: .details(title: "Square", text: detailsText))
                } label: {
                    Text("Details")
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(color: .blue, isConfigurable: true)
    }
}
