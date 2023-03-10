//
//  RectangleView.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 08/03/2023.
//

import SwiftUI

struct RectangleView: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Rectangle")
                .font(.title)
                .fontWeight(.bold)
            Rectangle()
                .foregroundColor(.yellow)
        }
    }
}

struct RectangleView_Previews: PreviewProvider {
    static var previews: some View {
        RectangleView()
    }
}
