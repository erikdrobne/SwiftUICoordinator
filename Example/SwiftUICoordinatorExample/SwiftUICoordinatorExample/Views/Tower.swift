//
//  Tower.swift
//  SwiftUICoordinatorExample
//
//  Created by Erik Drobne on 23/03/2023.
//

import SwiftUI

struct Tower: View {
    var body: some View {
        VStack(spacing: 0) {
            Capsule()
                .fill(.pink)
                .frame(width: 240, height: 80)
            Capsule()
                .fill(.gray)
                .frame(width: 240, height: 80)
            Capsule()
                .fill(.yellow)
                .frame(width: 240, height: 80)
            Capsule()
                .fill(.brown)
                .frame(width: 240, height: 80)
        }
    }
}

struct Tower_Previews: PreviewProvider {
    static var previews: some View {
        Tower()
    }
}
