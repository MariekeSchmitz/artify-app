//
//  VisualizationElement.swift
//  Artify
//
//  Created by Marieke Schmitz on 30.07.23.
//

import Foundation

struct VisualizationElement{
    
    var beatConfidence: Double = 0
    var beatLength: Double = 0
    
    var pitches = [Double]()
    var timbre = [Double]()
    var segmentLoudness: Double = 0

    var sectionChange: Bool = false
    var sectionCounter: Int = 0
    var sectionKey:Int = 0
    var sectionTempo: Double = 0
    var sectionLoudness: Double = 0
    
    var barChange: Bool = false
    var barCounter: Int = 0
    
    
}
