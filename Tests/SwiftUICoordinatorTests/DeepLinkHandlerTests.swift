//
//  DeepLinkHandlerTests.swift
//  
//
//  Created by Erik Drobne on 17/09/2023.
//

import XCTest
@testable import SwiftUICoordinator

final class DeepLinkHandlerTests: XCTestCase {

    @MainActor
    func test_linkForURLThrowsInvalidSchemeError() {
        let host = "circle"
        let url = URL(string: "://\(host)")

        XCTAssertThrowsError(try MockDeepLinkHandler.shared.link(for: XCTUnwrap(url))) { error in
            if let customError = error as? DeepLinkError {
                XCTAssertEqual(customError, .invalidScheme)
            } else {
                XCTFail("Expected an error of type DeepLinkError.")
            }
        }
    }

    @MainActor
    func test_linkForURLThrowsUnknownURLError() {
        let scheme = "myapp"
        let url = URL(string: "\(scheme)://")

        XCTAssertThrowsError(try MockDeepLinkHandler.shared.link(for: XCTUnwrap(url))) { error in
            if let customError = error as? DeepLinkError {
                XCTAssertEqual(customError, .unknownURL)
            } else {
                XCTFail("Expected an error of type DeepLinkError.")
            }
        }
    }

    @MainActor
    func test_linkForURLReturnsNil() {
        let scheme = "myapp"
        let action = "square"
        let url = URL(string: "\(scheme)://\(action)")

        XCTAssertNil(try MockDeepLinkHandler.shared.link(for: XCTUnwrap(url)))
    }

    @MainActor
    func test_linkForURLSuccess() {
        let scheme = "myapp"
        let action = "circle"
        let url = URL(string: "\(scheme)://\(action)")

        XCTAssertNoThrow(try {
            let link = try XCTUnwrap(MockDeepLinkHandler.shared.link(for: XCTUnwrap(url)))
            XCTAssertEqual(link.action, "circle")
            XCTAssertEqual(try XCTUnwrap(link.route as? MockRoute), .circle)
            XCTAssertTrue(link.params.isEmpty)
        }(), "Link for URL threw an error.")
    }

    @MainActor
    func test_paramsThrowsMissingQueryStringError() {
        let scheme = "myapp"
        let action = "circle"
        let url = URL(string: "\(scheme)://\(action)")
        let keys: Set<String> = ["color", "width", "height"]

        XCTAssertThrowsError(try MockDeepLinkHandler.shared.params(for: XCTUnwrap(url), and: keys)) { error in
            if let customError = error as? DeepLinkParamsError {
                XCTAssertEqual(customError, .missingQueryString)
            } else {
                XCTFail("Expected an error of type DeepLinkError.")
            }
        }
    }

    @MainActor
    func test_paramsReturnsEmptyCollection() {
        let scheme = "myapp"
        let action = "circle"
        let queryString = "abc=1"
        let url = URL(string: "\(scheme)://\(action)?\(queryString)")

        XCTAssertNoThrow(try {
            let params = try MockDeepLinkHandler.shared.params(for: XCTUnwrap(url), and: ["color", "width", "height"])
            XCTAssertTrue(params.isEmpty)
        }(), "Params for url threw an error.")
    }

    @MainActor
    func test_paramsForURLSuccess() {
        let scheme = "myapp"
        let action = "rectangle"
        let queryString = "color=blue&width=100&height=200"
        let url = URL(string: "\(scheme)://\(action)?\(queryString)")

        XCTAssertNoThrow(try {
            let params = try MockDeepLinkHandler.shared.params(for: XCTUnwrap(url), and: ["color", "width", "height"])
            XCTAssertEqual(params["color"], "blue")
            XCTAssertEqual(params["width"], "100")
            XCTAssertEqual(params["height"], "200")
        }(), "Params for url threw an error.")
    }
}
