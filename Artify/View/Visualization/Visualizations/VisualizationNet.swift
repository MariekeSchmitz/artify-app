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
    
    var colorPerPitch:[UIColor] = []

    
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
        
        radius = 20
        counterBeatsVisualizedInCurrentSegment = 0
        
        numSections = musicAnalysisVM.audioAnalysis.sections.count
        
        if (numSections > 6) {
            radiusPerSection = 3

        } else {
            radiusPerSection = radius/Double(numSections)

        }
        
 
//        midValuesGrid = constructGridMidpoints(numberOfAreas:numSections)
        
        positionPerSection = [CGPoint](repeating: CGPoint(), count: numSections)
        anglePerSection = [Double](repeating: Double(), count: numSections)
        colorPerPitch = [
            UIColor(red: 232, green: 255, blue: 72, alpha: 1),
            UIColor(red: 106 , green: 255, blue: 96, alpha: 1),
            UIColor(red: 96, green: 255, blue: 202, alpha: 1),
            UIColor(red: 94, green: 249, blue: 255, alpha: 1),
            UIColor(red: 22, green: 138, blue: 255, alpha: 1),
            UIColor(red: 152, green: 77, blue: 255, alpha: 1),
            UIColor(red: 242, green: 65, blue: 255, alpha: 1),
            UIColor(red: 255, green: 60, blue: 147, alpha: 1),
            UIColor(red: 255, green: 82, blue: 65, alpha: 1),
            UIColor(red: 255, green: 136, blue: 62, alpha: 1),
            UIColor(red: 255, green: 172, blue: 0, alpha: 1),
            UIColor(red: 233, green: 255, blue: 212, alpha: 1)
        ]

        
        for i in 0..<numSections {
            let x:Double = .random(in: (centerX - width/7)...(centerX + width/7))
            print(width)
            print(centerX)
            print(x)
            let y:Double = .random(in: (centerY - height/4)...(centerY + height/4))
            
            let p = CGPoint(x: x, y: y)
            positionPerSection[i] = p
            
            let angle = 2 * .pi / Double(musicAnalysisVM.beatsPerSection[i]!)
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
        
        
        let sectionNum = visualisationData.sectionCounter
        
        let sectionChange = visualisationData.sectionChange

        if (sectionChange) {
            counterBeatsVisualizedInCurrentSegment = 0
            
            var circleBlur = drawCircle(radius: 50, posX: positionPerSection[sectionNum].x, posY: positionPerSection[sectionNum].y, fillColor: SKColor(white: 1, alpha: 0.3))

            let effectNode = SKEffectNode()
                    effectNode.shouldRasterize = true
                    effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": 90])
                    effectNode.addChild(circleBlur)

            scene.addChild(effectNode)
            

        } else {
            counterBeatsVisualizedInCurrentSegment += 1
        }
        
        if (step == 1) {
            var circleBlur = drawCircle(radius: 50, posX: positionPerSection[sectionNum].x, posY: positionPerSection[sectionNum].y, fillColor: SKColor(white: 1, alpha: 0.3))

            let effectNode = SKEffectNode()
                    effectNode.shouldRasterize = true
                    effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": 80])
                    effectNode.addChild(circleBlur)

            scene.addChild(effectNode)
        }
        
        
        
        
        let stepsInCircle = musicAnalysisVM.beatsPerSection[sectionNum]
        
        let startPoint = positionPerSection[sectionNum]
        let endPoint = CGPoint(x: getX(angle: anglePerSection[sectionNum], step: counterBeatsVisualizedInCurrentSegment, radius: radiusPerSection * intenseLoudness) + startPoint.x,
                               y: getY(angle: anglePerSection[sectionNum], step: counterBeatsVisualizedInCurrentSegment, radius: radiusPerSection * intenseLoudness) + startPoint.y)
        
        let middlePoint =  CGPoint(x: (startPoint.x + endPoint.x) / 2, y: (startPoint.y + endPoint.y) / 2)
        let controls = findControlPoints(angle: anglePerSection[sectionNum] * Double(counterBeatsVisualizedInCurrentSegment), middle: middlePoint, distance: 5 * intenseLoudness)
        
        
        let controlPoint1 = controls[0]
        let controlPoint2 = controls[1]
        
        
        let pitches = visualisationData.pitches
        
        var color = colorPerPitch[findDominantPitch(pitches: pitches)]
        print(color)
        
        let curve = drawCurve(startPoint: startPoint, endPoint: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2, lineColor: color)
        let circle = drawCircle(radius: 2, posX: endPoint.x, posY: endPoint.y, fillColor: color)
        circle.glowWidth = 2
        
        scene.addChild(curve)
        scene.addChild(circle)
        
        
        
        if (counterBeatsVisualizedInCurrentSegment == 0 && sectionNum > 0) {
            
            let startPoint = positionPerSection[sectionNum - 1]
            let endPoint = positionPerSection[sectionNum - 1]
            
            let middlePoint =  CGPoint(x: (startPoint.x + endPoint.x) / 2, y: (startPoint.y + endPoint.y) / 2)
            let controls = findControlPoints(angle: anglePerSection[sectionNum], middle: middlePoint, distance: 100)
            let controlPoint1 = controls[0]
            let controlPoint2 = controls[1]
            let connectionCurve = drawCurve(startPoint: startPoint, endPoint: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2, lineColor: SKColor.white)
            scene.addChild(connectionCurve)

        }
        


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
    
    func findDominantPitch(pitches:[Double]) -> Int {
        
        var maxValue:Double = 0
        var maxIndex = 0
        
        for i in 0..<12 {
            if pitches[i] > maxValue {
                maxValue = pitches[i]
                maxIndex = i
            }
        }
        print(maxIndex)
        return maxIndex
 
    }
    
    func findControlPoints (angle:CGFloat, middle:CGPoint, distance:CGFloat) -> [CGPoint]{
        
        let xOffset1 = CGFloat(50) * cos(angle + .pi/2)
        let yOffset1 = CGFloat(50) * sin(angle + .pi/2)
        let point1 = CGPoint(x: middle.x + xOffset1, y: middle.y + yOffset1)
        
        let xOffset2 = -CGFloat(50) * cos(angle + .pi/2)
        let yOffset2 = -CGFloat(50) * sin(angle + .pi/2)
        let point2 = CGPoint(x: middle.x + xOffset2, y: middle.y + yOffset2)
             
        return [point1, point2]
        
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


