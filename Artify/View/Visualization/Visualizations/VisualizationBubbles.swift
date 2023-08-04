//
//  VisualizationSceneBubbles.swift
//  Artify
//
//  Created by Marieke Schmitz on 03.08.23.
//

import Foundation
import SpriteKit


class VisualizationBubbles : Visualization{
    
    override init(visualitationValues:[VisualizationElement], centerX:Double, centerY:Double, width:Double, height:Double) {
        super.init(visualitationValues: visualitationValues, centerX: centerX, centerY: centerY, width:width, height:height)
        angle = 2 * .pi / Double(visualizationValues.count)
        for i in 0..<pitchRadius.count {
            pitchRadius[i] = radius/12 * Double(i)
        }
    }
    
    override func visualizeBeat(scene:VisualizationScene, step:Int, visualisationData:VisualizationElement) {
        
        //        let ScalePBup = SKAction.scale(x:50, y:50 , duration: 2)
        //        let ScalePBdown = SKAction.scale(x:-50, y: -50,  duration: 2)
        
        if (visualisationData.sectionChange) {
            let circle = drawCircle(radius: 100, posX: getX(angle: angle, step: step, radius: 100) + centerX , posY: getY(angle: angle, step: step, radius: 100) + centerY, fillColor: SKColor.randomTransparent)
//            circle.run(SKAction.repeatForever(SKAction.sequence([ScalePBup,ScalePBdown])))
            scene.addChild(circle)
        }
        
        let pitches = visualisationData.pitches
        for j in 0..<pitches.count {
            
//            let highValue = pitches[j] == 1
//            var circleRadius = 0.0
//
//            if (highValue) {
//                circleRadius = 5
//            } else {
//                circleRadius = 10 * pitches[j]
//            }
            
            let circle = drawCircle(radius: 10 * pitches[j], posX: getX(angle: angle, step: step, radius: pitchRadius[j]) + centerX , posY: getY(angle: angle, step: step, radius: pitchRadius[j]) + centerY, fillColor: SKColor.random)
            
//            if (highValue && .random(in: 0...50) == 1) {
//                let duration:Double = .random(in:8...10)
////                let ScalePBup = SKAction.scale(to: 10 * pitches[j], duration: duration)
////                let ScalePBdown = SKAction.scale(to: -10 * pitches[j], duration: duration)
////                circle.run(ScalePBup)
//            }
            
//            circle.physicsBody = SKPhysicsBody(circleOfRadius: 10)
 
            scene.addChild(circle)
        }
    }
}
