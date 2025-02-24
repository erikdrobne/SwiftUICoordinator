//
//  DeepLinkTests.swift
//  
//
//  Created by Erik Drobne on 17/09/2023.
//
import Testing
import Foundation
@testable import SwiftUICoordinator

@MainActor
@Suite("Deep Link Tests") struct DeepLinkTests {

    @Test func testDeepLinksWithoutParametersAreEqual() {
        // Arrange
        let linkA = DeepLink(action: "square", route: MockRoute.square)
        let linkB = DeepLink(action: "square", route: MockRoute.square)
        let linkC = DeepLink(action: "rectangle", route: MockRoute.rectangle)

        // Assert
        #expect(linkA == linkB)
        #expect(linkA != linkC)
        #expect(linkB != linkC)
    }

    @Test func testDeepLinksWithParametersAreEqual() {
        // Arrange
        let linkA = DeepLink(action: "square", route: MockRoute.square, params: [])
        let linkB = DeepLink(action: "square", route: MockRoute.square, params: ["color"])
        let linkC = DeepLink(action: "square", route: MockRoute.rectangle, params: ["width"])

        // Assert
        #expect(linkA == linkB)
        #expect(linkA == linkC)
        #expect(linkB == linkC)
    }
}
