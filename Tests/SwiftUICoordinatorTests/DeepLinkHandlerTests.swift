//
//  DeepLinkHandlerTests.swift
//  
//
//  Created by Erik Drobne on 17/09/2023.
//

import Testing
import Foundation
@testable import SwiftUICoordinator

@MainActor
@Suite("Deep Link Handler Tests") struct DeepLinkHandlerTests {

    @Test func testLinkForURLThrowsInvalidSchemeError() {
        // Arrange
        let host = "circle"
        let url = URL(string: "://\(host)")

        // Act / Assert
        #expect(throws: DeepLinkError.invalidScheme) {
            _ = try MockDeepLinkHandler.shared.link(for: try #require(url))
        }
    }

    @Test func testLinkForURLThrowsUnknownURLError() {
        // Arrange
        let scheme = "myapp"
        let url = URL(string: "\(scheme)://")

        // Act / Assert
        #expect(throws: DeepLinkError.unknownURL) {
            _ = try MockDeepLinkHandler.shared.link(for: try #require(url))
        }
    }

    @Test func testLinkForURLReturnsNil() {
        // Arrange
        let scheme = "myapp"
        let action = "square"
        let url = URL(string: "\(scheme)://\(action)")

        // Act
        let link = try? MockDeepLinkHandler.shared.link(for: try #require(url))
        
        // Assert
        #expect(link == nil)
    }

    @Test func testLinkForURLSuccess() throws {
        // Arrange
        let scheme = "myapp"
        let action = "circle"
        let url = URL(string: "\(scheme)://\(action)")

        // Act
        let unwrappedURL = try #require(url)
        let link = try MockDeepLinkHandler.shared.link(for: unwrappedURL)
        let unwrappedLink = try #require(link)
        
        // Assert
        #expect(unwrappedLink.action == "circle")
        #expect(unwrappedLink.route as? MockRoute == .circle)
        #expect(unwrappedLink.params.isEmpty)
    }

    @Test func testParamsThrowsMissingQueryStringError() {
        // Arrange
        let scheme = "myapp"
        let action = "circle"
        let url = URL(string: "\(scheme)://\(action)")
        let keys: Set<String> = ["color", "width", "height"]

        // Act / Assert
        #expect(throws: DeepLinkParamsError.missingQueryString) {
            _ = try MockDeepLinkHandler.shared.params(for: try #require(url), and: keys)
        }
    }

    @Test func testParamsReturnsEmptyCollection() throws {
        // Arrange
        let scheme = "myapp"
        let action = "circle"
        let queryString = "abc=1"
        let url = URL(string: "\(scheme)://\(action)?\(queryString)")

        // Act
        let unwrappedURL = try #require(url)
        let params = try MockDeepLinkHandler.shared.params(for: unwrappedURL, and: ["color", "width", "height"])
        
        // Assert
        #expect(params.isEmpty)
    }

    @Test func testParamsForURLSuccess() throws {
        // Arrange
        let scheme = "myapp"
        let action = "rectangle"
        let queryString = "color=blue&width=100&height=200"
        let url = URL(string: "\(scheme)://\(action)?\(queryString)")

        // Act
        let unwrappedURL = try #require(url)
        let params = try MockDeepLinkHandler.shared.params(for: unwrappedURL, and: ["color", "width", "height"])
        
        // Assert
        #expect(params["color"] == "blue")
        #expect(params["width"] == "100")
        #expect(params["height"] == "200")
    }
}
