//
//  VisualizationSceneBubbles.swift
//  Artify
//
//  Created by Marieke Schmitz on 03.08.23.
//

import Foundation
import SpriteKit


class VisualizationBubbles : Visualization{
    
    private var audioFeatureColor:AudioFeatureColor = AudioFeatureColor.Colors
    private var colorfulColors = UIColor().getColorful()
    private var colorVariations:[UIColor] = []
    
    override init(visualitationValues:[VisualizationElement], centerX:Double, centerY:Double, width:Double, height:Double) {
        super.init(visualitationValues: visualitationValues, centerX: centerX, centerY: centerY, width:width, height:height)
        angle = 2 * .pi / Double(visualizationValues.count)
        for i in 0..<pitchRadius.count {
            pitchRadius[i] = radius/12 * Double(i)
        }
        
        audioFeatureColor = musicAnalysisVM.audioFeatureColor

        
        if (audioFeatureColor == .Colors) {
            colorVariations = colorfulColors
            for i in 0..<colorVariations.count {
                
                let color = colorVariations[i]
                
                var red: CGFloat = 0
                var green: CGFloat = 0
                var blue: CGFloat = 0
                var alpha: CGFloat = 0
                
                let factor:CGFloat = 20
                
                if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
                    let newRed = max(0, red/factor) - 0.2
                    let newGreen = max(0, green/factor) - 0.2
                    let newBlue = max(0, blue/factor) - 0.2
                    
                    colorVariations[i] = UIColor(red: Double(newRed), green: Double(newGreen), blue: Double(newBlue), alpha: Double(0.2))
                }
            }

        } else {
            colorVariations = audioFeatureColor.color.generateVariations(count: 12, step: 0.2)
            
            for i in 0..<colorVariations.count {
                
                colorVariations[i] = editColorBrightness(color: colorVariations[i], factor: 3, alpha: 0.6)
                
            }
        }
    }
    
    override func visualizeBeat(scene:VisualizationScene, step:Int, visualisationData:VisualizationElement) {
        
        if (visualisationData.sectionChange) {
            let circle = drawCircle(radius: 100, posX: getX(angle: angle, step: step, radius: 100) + centerX , posY: getY(angle: angle, step: step, radius: 100) + centerY, fillColor: colorVariations[.random(in: 0..<12)].withAlphaComponent(0.5))
            scene.addChild(circle)
        }
        
        let pitches = visualisationData.pitches
        for j in 0..<pitches.count {
            let newRadius = mapValue(pitches[j], minValue: 0, maxValue: 1)
            let sqrRadius = newRadius * newRadius
            
            let circle = drawCircle(radius: 10 * sqrRadius , posX: getX(angle: angle, step: step, radius: pitchRadius[j]) + centerX , posY: getY(angle: angle, step: step, radius: pitchRadius[j]) + centerY, fillColor: colorVariations[.random(in: 0..<12)].withAlphaComponent(0.5))
 
            scene.addChild(circle)
        }
    }
}
