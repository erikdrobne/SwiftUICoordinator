//
//  File.swift
//  
//
//  Created by Erik Drobne on 13/09/2023.
//

import Foundation

public protocol DeepLinkHandling {
    var scheme: String { get }
    var links: Set<DeepLink> { get }
    func link(for url: URL) throws -> DeepLink?
    func params(for url: URL, and keys: [String]) throws -> [String: String]
}

extension DeepLinkHandling {
    func link(for url: URL) throws -> DeepLink? {
        guard url.scheme == scheme else {
            throw DeepLinkError.invalidScheme
        }
        
        guard let action = url.host else {
            throw DeepLinkError.unknownURL
        }
        
        return links.first(where: { $0.action == action })
    }
    
    func params(for url: URL, and keys: [String]) throws -> [String: String] {
        guard let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems else {
            throw DeepLinkError.invalidQueryString
        }
        
        let params = queryItems
            .filter { keys.contains($0.name) }
            .reduce(into: [String: String]()) { result, queryItem in
                result[queryItem.name] = queryItem.value
            }
        
        return params
    }
}
