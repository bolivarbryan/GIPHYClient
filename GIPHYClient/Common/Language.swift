//
//  Language.swift
//  GIPHYClient
//
//  Created by Bryan A Bolivar M on 2/22/19.
//  Copyright © 2019 BolivarBryan. All rights reserved.
//

import Foundation

enum Language: String {
    case appName = "appName"

    var localized: String {
        return NSLocalizedString(self.rawValue, comment: self.rawValue)
    }
}
