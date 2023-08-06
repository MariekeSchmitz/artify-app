//
//  Visualization.swift
//  Artify
//
//  Created by Marieke Schmitz on 03.08.23.
//

import SwiftUI

class Visualization {
    var musicAnalysisVM = MusicAnalysisViewModel.shared
    var playVM = PlayerViewModel.shared
    var angle:Double = 0
    var pitchRadius = [Double](repeating:0, count: 12)
    var radius:Double = 300
    var visualizationValues: [VisualizationElement] = []
    var centerX:Double = 0
    var centerY:Double = 0
    var width:Double = 0
    var height:Double = 0

    init() {
        
    }
    
    init(visualitationValues:[VisualizationElement], centerX:Double, centerY:Double, width:Double, height:Double) {
        self.visualizationValues = visualitationValues
        self.centerX = centerX
        self.centerY = centerY
        self.width = width
        self.height = height

    }
    
    func visualizeBeat(scene:VisualizationScene, step:Int, visualisationData:VisualizationElement) {
    }
    
    func mapValue(_ value: Double, minValue:Double = 0.3, maxValue:Double = 0.8) -> Double {

        let normalizedValue = (value - minValue) / (maxValue - minValue)
        return max(0, min(1, normalizedValue))
    }
    
    func editColorBrightness(color:UIColor, factor:CGFloat, alpha:CGFloat = 0) -> UIColor {
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        
        let factor:CGFloat = 10
        
        if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let newRed = max(0, red * factor)
            let newGreen = max(0, green * factor)
            let newBlue = max(0, blue * factor)
            
            return UIColor(red: Double(newRed), green: Double(newGreen), blue: Double(newBlue), alpha: Double(alpha))
        }
        
        return color
    }
}
