//
//  NavigationTransition.swift
//  
//
//  Created by Erik Drobne on 12/12/2022.
//

import Foundation
import SwiftUI

public enum NavigationTransition {
    case push(animated: Bool = true)
    case present(animated: Bool = true, modalPresentationStyle: UIModalPresentationStyle = .automatic, completion: (() -> Void)? = nil)
}
