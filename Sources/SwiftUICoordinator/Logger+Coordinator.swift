//
//  File.swift
//  
//
//  Created by Erik Drobne on 14/09/2023.
//

import Foundation
import OSLog

extension Logger {
    private static let subsystem = "SwiftUICoordinator"
    
    /// Logs related to deep links.
    static let deepLink = Logger(subsystem: subsystem, category: "deep_link")
}
