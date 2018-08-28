//
//  ColorPalette.swift
//  TravelChallenge
//
//  Created by Italo Boss on 28/08/18.
//  Copyright © 2018 Dinamite Pangalactica. All rights reserved.
//

import UIKit

// MARK: - Color Palette

enum ColorPalette {
    case primaryColor
    case secondaryColor
    case accentColor
}

extension ColorPalette {
    var value: UIColor {
        get {
            // Modificar para paleta a ser definida
            switch self {
            case .primaryColor:
                return UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            case .secondaryColor:
                return UIColor(red: 0, green: 1, blue: 0, alpha: 1)
            case .accentColor:
                return UIColor(red: 1, green: 1, blue: 0, alpha: 1)
            }
        }
    }
}
