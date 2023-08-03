//
//  Visualizations.swift
//  Artify
//
//  Created by Marieke Schmitz on 03.08.23.
//

import Foundation

enum VisualizationType : CustomStringConvertible, CaseIterable {
    case Bubble
    case Lines
    
    init?(id : Int) {
        switch id {
        case 1: self = .Bubble
        case 2: self = .Lines
        default: return nil
        }
    }
    
    var description: String {
        switch self {
        case .Bubble: return "Bubble"
        case .Lines: return "Lines"
        }
    }
}
