//
//  VisualizationModifier.swift
//  Artify
//
//  Created by Marieke Schmitz on 04.08.23.
//

import Foundation
enum VisualizationModifier : CustomStringConvertible, CaseIterable {
    case ScaleUp
    case ScaleDown
    case Move
    case Remove
    
    init?(id : Int) {
        switch id {
        case 1: self = .ScaleUp
        case 2: self = .ScaleDown
        case 3: self = .Move
        case 4: self = .Remove
        default: return nil
        }
    }
    
    var description: String {
        switch self {
        case .ScaleUp: return "Vergrößern"
        case .ScaleDown: return "Verkleinern"
        case .Move: return "Bewegen"
        case .Remove: return "Fallen"
        }
    }
}
