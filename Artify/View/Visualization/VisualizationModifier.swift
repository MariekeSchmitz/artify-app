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
    
    init?(id : Int) {
        switch id {
        case 1: self = .ScaleUp
        case 2: self = .ScaleDown
        case 3: self = .Move
        default: return nil
        }
    }
    
    var description: String {
        switch self {
        case .ScaleUp: return "Scale up"
        case .ScaleDown: return "Scale up"
        case .Move: return "Move"
        }
    }
}
