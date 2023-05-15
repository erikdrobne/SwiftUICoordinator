//
//  Utilities.swift
//  
//
//  Created by Erik Drobne on 16/03/2023.
//

import Foundation
import SwiftUI

public extension View {
    @ViewBuilder
    func ifLet<T, Content: View>(_ value: T?, modifier: (Self, T) -> Content) -> some View {
        if let value = value {
            modifier(self, value)
        } else {
            self
        }
    }
}
