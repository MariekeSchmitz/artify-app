//
//  VisualizationNet.swift
//  Artify
//
//  Created by Marieke Schmitz on 04.08.23.
//

import Foundation
import SpriteKit

class VisualizationNet : Visualization {
    
    var maxSegmentLoudness:Double = 0
    var minSegmentLoudness:Double = 0
    var segmentLoudnessRange:Double = 0
    
    var maxSectionLoudness:Double = 0
    var minSectionLoudness:Double = 0
    var sectionLoudnessRange:Double = 0
    var sectionToggle: Bool = false
    var numSections: Int = 0
    
    var radiusPerSection: Double = 0
    var positionPerSection:[CGPoint] = []
    var anglePerSection:[Double] = []
    
    var columns = 3
    var rows = 4
    
    var midValuesGrid:[CGPoint] = []
    var stepsPerCircle = 0
    
    var counterBeatsVisualizedInCurrentSegment = 0
    
    
    override init(visualitationValues:[VisualizationElement], centerX:Double, centerY:Double, width:Double, height:Double) {
        super.init(visualitationValues: visualitationValues, centerX: centerX, centerY: centerY, width:width, height:height)
        
        for i in 0..<pitchRadius.count {
            pitchRadius[i] = radius/12 * Double(i)
        }
        maxSegmentLoudness = musicAnalysisVM.maxSegmentLoudness
        minSegmentLoudness = musicAnalysisVM.minSegmentLoudness
        segmentLoudnessRange = maxSegmentLoudness - minSegmentLoudness
        
        maxSectionLoudness = musicAnalysisVM.maxSectionLoudness
        minSectionLoudness = musicAnalysisVM.minSectionLoudness
        
        sectionLoudnessRange = maxSectionLoudness - minSectionLoudness
        
        radius = 10
        
        numSections = musicAnalysisVM.audioAnalysis.sections.count
        radiusPerSection = radius/Double(numSections)
 
//        midValuesGrid = constructGridMidpoints(numberOfAreas:numSections)
        
        positionPerSection = [CGPoint](repeating: CGPoint(), count: numSections)
        anglePerSection = [Double](repeating: Double(), count: numSections)
        
        for i in 0..<numSections {
            var x:Double = .random(in: (centerX - width/7)...(centerX + width/7))
            print(width)
            print(centerX)
            print(x)
            var y:Double = .random(in: (centerY - height/4)...(centerY + height/4))
            
            var p = CGPoint(x: x, y: y)
            positionPerSection[i] = p
            
            var angle = 2 * .pi / Double(musicAnalysisVM.beatsPerSection[i]!)
            anglePerSection[i] = angle
        }
        
        print("angles: ", anglePerSection)
        
        

        
        
    }
    
    override func visualizeBeat(scene: VisualizationScene, step: Int, visualisationData: VisualizationElement) {

        let loudness = visualisationData.segmentLoudness
        let positiveLoudness = loudness - minSegmentLoudness
        let normalizedLoudnessTo10 = positiveLoudness/(segmentLoudnessRange/10)
        let normalizedLoudnessTo1 = positiveLoudness/(segmentLoudnessRange)
        let intenseLoudness = normalizedLoudnessTo10 * normalizedLoudnessTo10
//
//        let x = getX(angle: angle, step: step, radius: radius * intenseLoudness) + centerX
//        let y = getY(angle: angle, step: step, radius: radius * intenseLoudness) + centerY
//
//        let startPoint = CGPoint(x: centerX, y: centerY)
//        let controlPoint1 = CGPoint(x: centerX + 20, y: centerY + 20)
//        let controlPoint2 = CGPoint(x: centerX - 30, y: centerY - 30)
//        let endPoint = CGPoint(x: x, y: y)
//
//        let curve = drawCurve(startPoint: startPoint, endPoint: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
//        let circle = drawCircle(radius: 2, posX: x, posY: y)
//
//        scene.addChild(curve)
//        scene.addChild(circle)
        let sectionChange = visualisationData.sectionChange

        if (sectionChange) {
            counterBeatsVisualizedInCurrentSegment = 0
        } else {
            counterBeatsVisualizedInCurrentSegment += 1
        }
        
        let sectionNum = visualisationData.sectionCounter
        

        let stepsInCircle = musicAnalysisVM.beatsPerSection[sectionNum]
        
        let startPoint = positionPerSection[sectionNum]
        let controlPoint1 = CGPoint(x: (startPoint.x + .random(in: -10...10)), y: (startPoint.y + .random(in: -10...10)))
        let controlPoint2 = CGPoint(x: (startPoint.x + .random(in: -10...70)), y: (startPoint.y + .random(in: -10...10)))
        let endPoint = CGPoint(x: getX(angle: anglePerSection[sectionNum], step: counterBeatsVisualizedInCurrentSegment, radius: radiusPerSection * intenseLoudness) + startPoint.x,
                               y: getY(angle: anglePerSection[sectionNum], step: counterBeatsVisualizedInCurrentSegment, radius: radiusPerSection * intenseLoudness) + startPoint.y)
        let curve = drawCurve(startPoint: startPoint, endPoint: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        let circle = drawCircle(radius: 2, posX: endPoint.x, posY: endPoint.y)

        circle.glowWidth = 2
        
        scene.addChild(curve)
        scene.addChild(circle)
        
//        for pos in positionPerSection {
//
//            var circle = drawCircle(radius: 10, posX: pos.x, posY: pos.y)
//            scene.addChild(circle)
//        }


    }
    
    func constructGridMidpoints(numberOfAreas:Int) -> [CGPoint] {
        let areaWidth = width / sqrt(CGFloat(numberOfAreas))
        let areaHeight = height / sqrt(CGFloat(numberOfAreas))
        
        let columns = Int(width / areaWidth)
        let rows = Int(height / areaHeight)
        
        var midpoints: [CGPoint] = []
        
        for row in 0..<rows {
            for column in 0..<columns {
                let midX = CGFloat(column) * areaWidth + areaWidth / 2
                let midY = CGFloat(row) * areaHeight + areaHeight / 2
                
                midpoints.append(CGPoint(x: midX, y: midY))
            }
        }
        print(midpoints)
        return midpoints
    }
    
    
        
        
    
    






    
    func mapValue(_ value: Double) -> Double {
        // Assuming your input range is 0.3 to 0.8
        let minValue = 0.3
        let maxValue = 0.8
        
        // Normalize the value to the range 0 to 1
        let normalizedValue = (value - minValue) / (maxValue - minValue)
        
        // Make sure the normalized value is within the valid range
        return max(0, min(1, normalizedValue))
    }
    
}


