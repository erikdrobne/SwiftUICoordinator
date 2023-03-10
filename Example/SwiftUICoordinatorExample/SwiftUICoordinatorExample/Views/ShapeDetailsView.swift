//
//  ShapeDetailsView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 10/03/2023.
//

import SwiftUI

struct ShapeDetailsView: View {

    let title: String
    let text: String

    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .frame(alignment: .leading)
            Spacer()
                .frame(height: 24)
            Text(text)
            .font(.italic(.body)())
            .padding([.leading, .trailing], 12)
            Spacer()
        }
    }
}

struct ShapeDetailsView_Previews: PreviewProvider {

    static let text = "In Euclidean geometry, a square is a regular quadrilateral, which means that it has four equal sides and four equal angles (90-degree angles, π/2 radian angles, or right angles). It can also be defined as a rectangle with two equal-length adjacent sides. It is the only regular polygon whose internal angle, central angle, and external angle are all equal (90°), and whose diagonals are all equal in length. A square with vertices ABCD would be denoted."

    static var previews: some View {
        ShapeDetailsView(title: "Circle", text: text)
    }
}
