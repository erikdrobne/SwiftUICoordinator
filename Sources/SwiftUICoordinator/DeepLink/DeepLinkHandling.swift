//
//  DeepLinkHandling.swift
//  
//
//  Created by Erik Drobne on 13/09/2023.
//

import Foundation

@MainActor
public protocol DeepLinkHandling {
    /// URL scheme to use for opening links in your app
    var scheme: String { get }
    /// The set of supported deep links.
    var links: Set<DeepLink> { get }
    
    func link(for url: URL) throws(DeepLinkError) -> DeepLink?
    func params(for url: URL, and keys: Set<String>) throws(DeepLinkParamsError) -> [String: String]
}

// MARK: - Extensions

public extension DeepLinkHandling {
    
    /// Returns deep link or nil for a given URL.
    ///
    /// - Parameters:
    ///     - url: A URL that you want to match against registered deep links.
    ///
    /// - Throws ``DeepLinkError``:
    ///     - `DeepLinkError.invalidScheme`: Thrown if the URL's scheme doesn't match the
    ///     expected scheme defined in the scheme property.
    ///     - `DeepLinkError.unknownURL`: Thrown if the URL doesn't have a recognized 
    ///     action (host) that corresponds to any registered deep link.
    ///
    /// - Returns: ``DeepLink`` or `nil`.
    func link(for url: URL) throws(DeepLinkError) -> DeepLink? {
        guard url.scheme == scheme else {
            throw DeepLinkError.invalidScheme
        }
        
        guard let action = url.host else {
            throw DeepLinkError.unknownURL
        }
        
        return links.first(where: { $0.action == action })
    }
    
    /// Returns a dictionary of parameters for a given url and parameter keys.
    ///
    /// - Parameters:
    ///     - url: A URL from which you want to extract query parameters.
    ///     - keys: A set of strings representing the keys for the query parameters you want to extract.
    ///
    /// - Throws: An error of type ``DeepLinkParamsError`` `missingQueryString` in case of invalid query string.
    /// - Returns: A `[String: String]` where the keys are the names of the query items and the values are their
    /// corresponding values.
    func params(for url: URL, and keys: Set<String>) throws(DeepLinkParamsError) -> [String: String] {
        guard keys.count > 0 else {
            return [:]
        }

        guard let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems else {
            throw DeepLinkParamsError.missingQueryString
        }
        
        return queryItems
            .filter { keys.contains($0.name) }
            .reduce(into: [String: String]()) { result, queryItem in
                result[queryItem.name] = queryItem.value
            }
    }
}
