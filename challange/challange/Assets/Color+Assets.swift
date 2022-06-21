//
//  Color+Custom.swift
//  challange
//
//  Created by Inti Albuquerque on 20/06/22.
//

import Foundation
import SwiftUI

enum ColorNames: String {
    case loadingBackground = "LoadingBackground"
    case background = "Background"
    case subtitle = "Subtitle"
    case line = "Line"
    case listBackground = "ListBackground"
    case back = "Back"
    
    func color() -> Color {
        Color(self.rawValue)
    }
    
    func uiColor() -> UIColor? {
        UIColor(named: self.rawValue)
    }
}
