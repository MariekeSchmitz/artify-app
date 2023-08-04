//
//  VisualizationLoudness.swift
//  Artify
//
//  Created by Marieke Schmitz on 04.08.23.
//

import Foundation
import SpriteKit

class VisualizationLoudness : Visualization {
    
    var maxSegmentLoudness:Double = 0
    var minSegmentLoudness:Double = 0
    var segmentLoudnessRange:Double = 0
    
    var maxSectionLoudness:Double = 0
    var minSectionLoudness:Double = 0
    var sectionLoudnessRange:Double = 0
    
    var sectionToggle: Bool = false
    
    override init(visualitationValues:[VisualizationElement], centerX:Double, centerY:Double) {
        super.init( visualitationValues: visualitationValues, centerX: centerX, centerY: centerY)
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
        
        radius = 200
    }
    
    override func visualizeBeat(scene: VisualizationScene, step: Int, visualisationData: VisualizationElement) {
        
        
        let loudness = visualisationData.segmentLoudness
        let positiveLoudness = loudness - minSegmentLoudness
        let normalizedLoudnessTo10 = positiveLoudness/(segmentLoudnessRange/10)
        let normalizedLoudnessTo1 = positiveLoudness/(segmentLoudnessRange)

        let intenseLoudness = normalizedLoudnessTo10 * normalizedLoudnessTo10
        
        let beatConfidence = visualisationData.beatConfidence
        let sectionloudness = visualisationData.sectionLoudness
        let sectionKey = visualisationData.sectionKey
        let sectionTempo = visualisationData.sectionTempo
        let newSection = visualisationData.sectionChange
        
        if (newSection) {
            sectionToggle.toggle()
        }
        
        let color: UIColor
        
        var red:CGFloat = 1
        var green:CGFloat = 1 - normalizedLoudnessTo1
        var blue:CGFloat = 1 - normalizedLoudnessTo1
        var alpha = normalizedLoudnessTo1
        
        color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        
        let line = drawLine(
            startPoint: CGPoint(x: centerX, y: centerY),
            endPoint: CGPoint(x: getX(angle: angle, step: step, radius: radius/100 * intenseLoudness) + centerX ,
                              y: getY(angle: angle, step: step, radius: radius/100 * intenseLoudness) + centerY),
            lineColor: SKColor.init(white: 1, alpha: 0.3))
        scene.addChild(line)

        
        let circle = drawCircle(
            radius: normalizedLoudnessTo1 < 0.5 ? 1 : 0.7 * intenseLoudness,
            posX: getX(angle: angle, step: step, radius: radius*2/3 + radius * beatConfidence) + centerX ,
            posY: getY(angle: angle, step: step, radius: radius*2/3 + radius * beatConfidence) + centerY,
            fillColor: color
//            fillColor: SKColor.init(white: 1, alpha: normalizedLoudnessTo1 < 0.5 ? 1 : 0.05)
            
        )
        
        
        
        
        
        
        scene.addChild(circle)
        print("Loudness: ", sectionloudness, "Key: ", sectionKey, "     sectionTempo: ", sectionTempo)

//        print("Normalized: ", normalizedLoudnessTo1, "Intense: ", intenseLoudness, "     Loudness Segment: ", loudness)
        print(visualisationData.beatConfidence)
    }
    
}