//
//  DeepLinkError.swift
//  
//
//  Created by Erik Drobne on 13/09/2023.
//

import Foundation

public enum DeepLinkError: Error {
    case invalidScheme
    case unknownURL
}

public enum DeepLinkParamsError: Error {
    case missingQueryString
}
