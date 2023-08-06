//
//  AudioFeatureType.swift
//  Artify
//
//  Created by Marieke Schmitz on 04.08.23.
//

import Foundation
import SwiftUI

enum AudioFeatureColor : CaseIterable {
    case Colors
    case White
    case Blue
    case Red
    case Green
    case Yellow
    
    init?(id : Int) {
        switch id {
        case 1: self = .Colors
        case 2: self = .White
        case 3: self = .Blue
        case 4: self = .Red
        case 5: self = .Green
        case 6: self = .Yellow

        default: return nil
        }
    }
    
    var color: UIColor {
        switch self {
        case .Colors: return UIColor(red: 0, green: 0.2, blue: 0.2, alpha: 1)
        case .White: return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        case .Blue: return UIColor(red: 0, green: 0.2, blue: 0.5, alpha: 1)
        case .Red: return UIColor(red: 1, green: 0.1, blue: 0.2, alpha: 1)
        case .Green: return UIColor(red: 0, green: 1, blue: 0.2, alpha: 1)
        case .Yellow: return UIColor(red: 0.9, green: 0.7, blue: 0.2, alpha: 1)
        }
    }
    
    var description: String {
        switch self {
        case .Colors: return "All colors"
        case .White: return "White"
        case .Blue: return "Blue"
        case .Red: return "Red"
        case .Green: return "Green"
        case .Yellow: return "Yellow"


        }
    }
}
