//
//  VisualizationNet.swift
//  Artify
//
//  Created by Marieke Schmitz on 04.08.23.
//

import Foundation
import SpriteKit

class VisualizationNet : Visualization {
    
    private var maxSegmentLoudness:Double = 0
    private var minSegmentLoudness:Double = 0
    private var segmentLoudnessRange:Double = 0
    
    private var maxSectionLoudness:Double = 0
    private var minSectionLoudness:Double = 0
    private var sectionLoudnessRange:Double = 0
    private var sectionToggle: Bool = false
    private var numSections: Int = 0
    
    private var radiusPerSection: Double = 0
    private var positionPerSection:[CGPoint] = []
    private var anglePerSection:[Double] = []
    
    private var colorPerPitch:[UIColor] = []
    
    private var counterBeatsVisualizedInCurrentSegment = 0
    

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
        
 
        positionPerSection = [CGPoint](repeating: CGPoint(), count: numSections)
        anglePerSection = [Double](repeating: Double(), count: numSections)

        
        let audioFeatureType = musicAnalysisVM.audioFeatureColor
        
        if(audioFeatureType == .Colors) {
            colorPerPitch = UIColor().getColorful()
        } else {
            colorPerPitch = audioFeatureType.color.generateVariations(count: 12)
        }
        
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
        
        
    }
    
    override func visualizeBeat(scene: VisualizationScene, step: Int, visualisationData: VisualizationElement) {

        let loudness = visualisationData.segmentLoudness
        let positiveLoudness = loudness - minSegmentLoudness
        let normalizedLoudnessTo10 = positiveLoudness/(segmentLoudnessRange/10)
        let intenseLoudness = normalizedLoudnessTo10 * normalizedLoudnessTo10
        
        
        let sectionNum = visualisationData.sectionCounter
        
        let sectionChange = visualisationData.sectionChange

        if (sectionChange) {
            counterBeatsVisualizedInCurrentSegment = 0
            
            let circleBlur = drawCircle(radius: 50, posX: positionPerSection[sectionNum].x, posY: positionPerSection[sectionNum].y, fillColor: SKColor(white: 1, alpha: 0.3))

            let effectNode = SKEffectNode()
                    effectNode.shouldRasterize = true
                    effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": 90])
                    effectNode.addChild(circleBlur)

            scene.addChild(effectNode)
            
            if (sectionNum > 0) {
                let startPoint = positionPerSection[sectionNum - 1]
                let endPoint = positionPerSection[sectionNum]
                
                let middlePoint =  CGPoint(x: (startPoint.x + endPoint.x) / 2, y: (startPoint.y + endPoint.y) / 2)
                let controls = findControlPoints(angle: anglePerSection[sectionNum]*Double(counterBeatsVisualizedInCurrentSegment), middle: middlePoint, distance: 100)
                let controlPoint1 = controls[0]
                let controlPoint2 = controls[1]
                let connectionCurve = drawCurve(startPoint: startPoint, endPoint: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2, lineColor: SKColor.white)
                scene.addChild(connectionCurve)
            }

        } else {
            counterBeatsVisualizedInCurrentSegment += 1
        }
        
        if (step == 1) {
            let circleBlur = drawCircle(radius: 50, posX: positionPerSection[sectionNum].x, posY: positionPerSection[sectionNum].y, fillColor: SKColor(white: 1, alpha: 0.3))

            let effectNode = SKEffectNode()
                    effectNode.shouldRasterize = true
                    effectNode.filter = CIFilter(name: "CIGaussianBlur", parameters: ["inputRadius": 80])
                    effectNode.addChild(circleBlur)

            scene.addChild(effectNode)
        }
        
        
        let startPoint = positionPerSection[sectionNum]
        let endPoint = CGPoint(x: getX(angle: anglePerSection[sectionNum], step: counterBeatsVisualizedInCurrentSegment, radius: radiusPerSection * intenseLoudness) + startPoint.x,
                               y: getY(angle: anglePerSection[sectionNum], step: counterBeatsVisualizedInCurrentSegment, radius: radiusPerSection * intenseLoudness) + startPoint.y)
        
        let middlePoint =  CGPoint(x: (startPoint.x + endPoint.x) / 2, y: (startPoint.y + endPoint.y) / 2)
        let controls = findControlPoints(angle: anglePerSection[sectionNum] * Double(counterBeatsVisualizedInCurrentSegment), middle: middlePoint, distance: 1 * intenseLoudness)
        
        
        let controlPoint1 = controls[0]
        let controlPoint2 = controls[1]
        
        
        let pitches = visualisationData.pitches
        
        let color = colorPerPitch[findDominantPitch(pitches: pitches)]
        
        let curve = drawCurve(startPoint: startPoint, endPoint: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2, lineColor: color)
        let circle = drawCircle(radius: 2, posX: endPoint.x, posY: endPoint.y, fillColor: color)
        circle.glowWidth = 2
        
        scene.addChild(curve)
        scene.addChild(circle)
        
        
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
        
        let xOffset1 = distance * cos(angle + .pi/2)
        let yOffset1 = distance * sin(angle + .pi/2)
        let point1 = CGPoint(x: middle.x + xOffset1, y: middle.y + yOffset1)
        
        let xOffset2 = -distance * cos(angle + .pi/2)
        let yOffset2 = -distance * sin(angle + .pi/2)
        let point2 = CGPoint(x: middle.x + xOffset2, y: middle.y + yOffset2)
             
        return [point1, point2]
        
    }
    


    
    
    
}


