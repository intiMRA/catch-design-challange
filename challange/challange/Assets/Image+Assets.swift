//
//  Image+Assets.swift
//  challange
//
//  Created by Inti Albuquerque on 20/06/22.
//

import Foundation
import SwiftUI

enum ImageNames: String {
    case logo = "Logo"
    
    func image() -> Image {
        Image(self.rawValue)
    }
}
