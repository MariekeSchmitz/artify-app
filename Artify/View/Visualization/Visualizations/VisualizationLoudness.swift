//
//  VisualizationLoudness.swift
//  Artify
//
//  Created by Marieke Schmitz on 04.08.23.
//

import Foundation
import SpriteKit

class VisualizationLoudness : Visualization {
    
    private var maxSegmentLoudness:Double = 0
    private var minSegmentLoudness:Double = 0
    private var segmentLoudnessRange:Double = 0
    
    private var maxSectionLoudness:Double = 0
    private var minSectionLoudness:Double = 0
    private var sectionLoudnessRange:Double = 0
    
    private var sectionToggle: Bool = false
    
    private var audioFeatureColor:AudioFeatureColors = AudioFeatureColors.Colors
    private var colorfulColors = UIColor().getColorful()
    private var colorVariations:[UIColor] = []
    
    override init(visualitationValues:[VisualizationElement], centerX:Double, centerY:Double, width:Double, height:Double) {
        super.init(visualitationValues: visualitationValues, centerX: centerX, centerY: centerY, width:width, height:height)
        angle = 2 * .pi / Double(visualizationValues.count)
        for i in 0..<pitchRadius.count {
            pitchRadius[i] = radius/12 * Double(i)
        }
        maxSegmentLoudness = musicAnalysisVM.maxSegmentLoudness
        minSegmentLoudness = musicAnalysisVM.minSegmentLoudness
        segmentLoudnessRange = maxSegmentLoudness - minSegmentLoudness
        
        maxSectionLoudness = musicAnalysisVM.maxSectionLoudness
        minSectionLoudness = musicAnalysisVM.minSectionLoudness
        sectionLoudnessRange = maxSectionLoudness - minSectionLoudness
        
        audioFeatureColor = musicAnalysisVM.audioFeatureColor
        
        if (audioFeatureColor == .Colors) {
            colorVariations = colorfulColors
            for i in 0..<colorVariations.count {
                
                let color = colorVariations[i]
                
                var red: CGFloat = 0
                var green: CGFloat = 0
                var blue: CGFloat = 0
                var alpha: CGFloat = 0
                
                let factor:CGFloat = 10
                
                if color.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
                    let newRed = max(0, red/factor)
                    let newGreen = max(0, green/factor)
                    let newBlue = max(0, blue/factor)
                    
                    colorVariations[i] = UIColor(red: Double(newRed), green: Double(newGreen), blue: Double(newBlue), alpha: Double(alpha))
                }
            }

        } else {
            colorVariations = audioFeatureColor.color.generateVariations(count: 12, step: 0.1)
        }
        
        radius = 200
    }
    
    override func visualizeBeat(scene: VisualizationScene, step: Int, visualisationData: VisualizationElement) {
        
        
        let loudness = visualisationData.segmentLoudness
        let positiveLoudness = loudness - minSegmentLoudness
        let normalizedLoudnessTo10 = positiveLoudness/(segmentLoudnessRange/10)
        let normalizedLoudnessTo1 = positiveLoudness/(segmentLoudnessRange)

        
        let intenseLoudness = normalizedLoudnessTo10 * normalizedLoudnessTo10
    
        let newSection = visualisationData.sectionChange
        let pitches = visualisationData.pitches
        
        
        if (newSection) {
            sectionToggle.toggle()
        }
        
        var alpha:Double = 0
        
        if (audioFeatureColor == .Colors) {
            alpha = normalizedLoudnessTo1 < 0.5 ? 0.5 : 0.003
        } else {
            alpha = normalizedLoudnessTo1 < 0.5 ? 1 : 0.05
        }
        
        
        let line = drawLine(
            startPoint: CGPoint(x: centerX, y: centerY),
            endPoint: CGPoint(x: getX(angle: angle, step: step, radius: radius/100 * intenseLoudness) + centerX ,
                              y: getY(angle: angle,
                                      step: step,
                                      radius: radius/100 * intenseLoudness) + centerY),
            lineColor: colorVariations[.random(in: 0..<12)].withAlphaComponent(0.3))
        scene.addChild(line)

        let circle = drawCircle(
            radius: normalizedLoudnessTo1 < 0.5 ? normalizedLoudnessTo1*10 : 0.7 * intenseLoudness,
            posX: getX(angle: angle, step: step, radius: radius*2/3 + radius * pitches[0]) + centerX ,
            posY: getY(angle: angle, step: step, radius: radius*2/3 + radius * pitches[0]) + centerY,
            fillColor: colorVariations[.random(in: 0..<12)].withAlphaComponent(alpha)
            
        )
        
        scene.addChild(circle)
    }
    
    
    
}
