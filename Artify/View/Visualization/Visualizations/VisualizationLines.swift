//
//  VisualizationLines.swift
//  Artify
//
//  Created by Marieke Schmitz on 03.08.23.
//

import Foundation
import SpriteKit


class VisualizationLines : Visualization{
    
    private var timbreRadius:Double = 0
    private var prevPitchLinePos = [CGPoint](repeating:CGPoint(), count: 12)
    private var pitchColors = [SKColor](repeating:SKColor(), count: 12)
    private var prevTimbreLinePos = [CGPoint](repeating:CGPoint(), count: 12)
    private var size = 1.0
    
    private var startXPitchLines:Double = 0
    private var startYPitchLines:Double = 0
    private var startXTimbreLines:Double = 0
    private var startYTimbreLines:Double = 0
    
    private var audioFeatureColor:AudioFeatureColors = AudioFeatureColors.Colors
    private var colorfulColors = UIColor().getColorful()

    
    override init(visualitationValues:[VisualizationElement], centerX:Double, centerY:Double, width:Double, height:Double) {
        super.init(visualitationValues: visualitationValues, centerX: centerX, centerY: centerY, width:width, height:height)
        
        angle = 2 * .pi / Double(visualitationValues.count)
        radius = 350
        timbreRadius = radius/3
        
        startXPitchLines = getX(angle: angle, step: 0, radius: radius) + centerX
        startYPitchLines = getY(angle: angle, step: 0, radius: radius) + centerY
        
        startXTimbreLines = getX(angle: angle, step: 0, radius: timbreRadius) + centerX
        startYTimbreLines = getY(angle: angle, step: 0, radius: timbreRadius) + centerY
        
        for i in 0..<pitchRadius.count {
            pitchRadius[i] = radius/12 * Double(i)
        }
        
        audioFeatureColor = musicAnalysisVM.audioFeatureColor
        
        if (visualitationValues.count != 0 ) {
            for i in 0..<prevPitchLinePos.count {

                prevPitchLinePos[i] = CGPoint(x: startXPitchLines, y:startYPitchLines)
                pitchColors[i] = i % 2 == 0 ? SKColor.white.withAlphaComponent(0.8) : audioFeatureColor.color.withAlphaComponent(0.3)
                
                if (audioFeatureColor == .Colors) {
                    pitchColors[i] = i % 2 == 0 ? SKColor.white.withAlphaComponent(0.8) : colorfulColors[i].withAlphaComponent(0.3)
                } else {
                    pitchColors[i] = i % 2 == 0 ? SKColor.white.withAlphaComponent(0.8) : audioFeatureColor.color.withAlphaComponent(0.3)
                }
                
                prevTimbreLinePos[i] = CGPoint(x: startXTimbreLines, y:startYTimbreLines)
                
            }
        }
        
        
        
    }
    
    override func visualizeBeat(scene:VisualizationScene, step:Int, visualisationData:VisualizationElement) {
                
        // bar-visualization
        if(visualisationData.barChange) {
            let circle = drawCircle(radius: 2, posX: getX(angle: angle, step: step, radius: radius*9/20) + centerX , posY: getY(angle: angle, step: step, radius: radius*9/20) + centerY, fillColor: SKColor.white)
            scene.addChild(circle)
        }
        
        // section-visualization
        if(visualisationData.sectionChange) {
            let circle = drawCircle(
                radius: 30,
                posX: getX(angle: angle, step: step, radius: radius*9/20) + centerX ,
                posY: getY(angle: angle, step: step, radius: radius*9/20) + centerY,
                fillColor: audioFeatureColor == .Colors ? colorfulColors[.random(in: 0..<12)] : audioFeatureColor.color.withAlphaComponent(0.4))
            scene.addChild(circle)
        }
        
        // pitch-visualization
        let pitches = visualisationData.pitches

        for j in 0..<pitches.count {

            var pitch = pitches[j]

            if pitch > 0.9 {
                pitch += .random(in: 0...0.5)
            }

            let newX = getX(angle: angle, step: step, radius: radius*1/2 + radius/2 * pitch) + centerX
            let newY = getY(angle: angle, step: step, radius: radius*1/2 + radius/2 * pitch) + centerY

            let line = drawLine(startPoint: prevPitchLinePos[j], endPoint: CGPoint(x: newX, y: newY), lineColor: pitchColors[j])
            scene.addChild(line)

            prevPitchLinePos[j] = CGPoint(x: newX, y: newY)
        }
        
        // timbre-visualization
        let timbre = visualisationData.timbre

        for j in 0..<timbre.count {

            var timbre = pitches[j]

            if timbre > 0.9 {
                timbre += .random(in: 0...0.1)
            }

            let newX = getX(angle: angle, step: step, radius: timbreRadius*1/2 + timbreRadius/2 * timbre) + centerX
            let newY = getY(angle: angle, step: step, radius: timbreRadius*1/2 + timbreRadius/2 * timbre) + centerY

            let line = drawLine(startPoint: prevTimbreLinePos[j], endPoint: CGPoint(x: newX, y: newY), lineColor: SKColor(white: 1, alpha: 0.3))
            scene.addChild(line)

            prevTimbreLinePos[j] = CGPoint(x: newX, y: newY)
        }
        
        
    }
}
