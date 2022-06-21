//
//  String+Localized.swift
//  challange
//
//  Created by Inti Albuquerque on 21/06/22.
//

import Foundation
extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
