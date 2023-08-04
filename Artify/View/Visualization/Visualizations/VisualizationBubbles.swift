//
//  VisualizationSceneBubbles.swift
//  Artify
//
//  Created by Marieke Schmitz on 03.08.23.
//

import Foundation
import SpriteKit


class VisualizationBubbles : Visualization{
    
    var audioFeatureColor:AudioFeatureColors = AudioFeatureColors.Colors
    var colorfulColors = UIColor().getColorful()
    var colorVariations:[UIColor] = []
    
    override init(visualitationValues:[VisualizationElement], centerX:Double, centerY:Double, width:Double, height:Double) {
        super.init(visualitationValues: visualitationValues, centerX: centerX, centerY: centerY, width:width, height:height)
        angle = 2 * .pi / Double(visualizationValues.count)
        for i in 0..<pitchRadius.count {
            pitchRadius[i] = radius/12 * Double(i)
        }
        
        audioFeatureColor = musicAnalysisVM.audioFeatureColor

        
        if (audioFeatureColor == .Colors) {
            colorVariations = colorfulColors
            print(colorVariations)
            for i in 0..<colorVariations.count {
                
                var color = colorVariations[i]
                
                var red: CGFloat = 0
                var green: CGFloat = 0
                var blue: CGFloat = 0
                var alpha: CGFloat = 0
                
                var factor:CGFloat = 20
                
                if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
                    let newRed = max(0, red/factor) - 0.2
                    let newGreen = max(0, green/factor) - 0.2
                    let newBlue = max(0, blue/factor) - 0.2
                    
                    colorVariations[i] = UIColor(red: Double(newRed), green: Double(newGreen), blue: Double(newBlue), alpha: Double(0.2))
                }
            }
            print(colorVariations)

        } else {
            colorVariations = audioFeatureColor.color.generateVariations(count: 12, step: 0.2)
            
            for i in 0..<colorVariations.count {
                
                var color = colorVariations[i]
                
                var red: CGFloat = 0
                var green: CGFloat = 0
                var blue: CGFloat = 0
                var alpha: CGFloat = 0
                
                var factor:CGFloat = 3
                
                if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
                    let newRed = max(0, red*3)
                    let newGreen = max(0, green*3)
                    let newBlue = max(0, blue*3)
                    
                    colorVariations[i] = UIColor(red: Double(newRed), green: Double(newGreen), blue: Double(newBlue), alpha: Double(0.6))
                }
            }
        }
    }
    
    override func visualizeBeat(scene:VisualizationScene, step:Int, visualisationData:VisualizationElement) {
        
        //        let ScalePBup = SKAction.scale(x:50, y:50 , duration: 2)
        //        let ScalePBdown = SKAction.scale(x:-50, y: -50,  duration: 2)
        
        
        
        if (visualisationData.sectionChange) {
            let circle = drawCircle(radius: 100, posX: getX(angle: angle, step: step, radius: 100) + centerX , posY: getY(angle: angle, step: step, radius: 100) + centerY, fillColor: colorVariations[.random(in: 0..<12)].withAlphaComponent(0.5))
//            circle.run(SKAction.repeatForever(SKAction.sequence([ScalePBup,ScalePBdown])))
            scene.addChild(circle)
        }
        
        let pitches = visualisationData.pitches
        for j in 0..<pitches.count {
            var newRadius = mapValue(pitches[j], minValue: 0, maxValue: 1)
            var sqrRadius = newRadius * newRadius
            
            let circle = drawCircle(radius: 10 * sqrRadius , posX: getX(angle: angle, step: step, radius: pitchRadius[j]) + centerX , posY: getY(angle: angle, step: step, radius: pitchRadius[j]) + centerY, fillColor: colorVariations[.random(in: 0..<12)].withAlphaComponent(0.5))
 
            scene.addChild(circle)
        }
    }
}
