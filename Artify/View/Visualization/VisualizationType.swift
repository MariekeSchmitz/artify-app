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
    case Loudness
    case Net 
    
    init?(id : Int) {
        switch id {
        case 1: self = .Bubble
        case 2: self = .Lines
        case 3: self = .Loudness
        case 4: self = .Net
        default: return nil
        }
    }
    
    var description: String {
        switch self {
        case .Bubble: return "Bubbles"
        case .Lines: return "Eye"
        case .Loudness: return "Circle"
        case .Net: return "Web"
        }
    }
}
