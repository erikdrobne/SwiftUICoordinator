//
//  File.swift
//  
//
//  Created by Erik Drobne on 17/09/2023.
//

import Foundation
import XCTest
@testable import SwiftUICoordinator

final class DeepLinkTests: XCTestCase {

    func test_deepLinksWithoutParametersAreEqual() {
        let linkA = DeepLink(action: "square", route: MockRoute.square)
        let linkB = DeepLink(action: "square", route: MockRoute.square)
        let linkC = DeepLink(action: "rectangle", route: MockRoute.rectangle)

        XCTAssertEqual(linkA, linkB)
        XCTAssertNotEqual(linkA, linkC)
        XCTAssertNotEqual(linkB, linkC)
    }

    func test_deepLinksWithParametersAreEqual() {
        let linkA = DeepLink(action: "square", route: MockRoute.square, params: [])
        let linkB = DeepLink(action: "square", route: MockRoute.square, params: ["color"])
        let linkC = DeepLink(action: "square", route: MockRoute.rectangle, params: ["width"])

        XCTAssertEqual(linkA, linkB)
        XCTAssertEqual(linkA, linkC)
        XCTAssertEqual(linkB, linkC)
    }
}
