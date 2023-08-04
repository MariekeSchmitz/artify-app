//
//  AudioFeatureType.swift
//  Artify
//
//  Created by Marieke Schmitz on 04.08.23.
//

import Foundation
import SwiftUI

enum AudioFeatureColors {
    case Slow
    case HighEnergy
    case MidEnergy
    case Instrumental
    
    var color: UIColor {
        switch self {
        case .Slow: return UIColor(red: 0, green: 0.2, blue: 0.2, alpha: 1)
        case .MidEnergy: return UIColor(red: 0.6, green: 0.9, blue: 0.55, alpha: 1)
        case .HighEnergy: return UIColor(red: 1, green: 0.8, blue: 0.2, alpha: 1)
        case .Instrumental: return UIColor(red: 0.6, green: 0.9, blue: 0.55, alpha: 1)

        }
    }
}
