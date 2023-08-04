//
//  VisualizationSceneA.swift
//  Artify
//
//  Created by Marieke Schmitz on 01.08.23.
//

import Foundation
import SwiftUI
import SpriteKit

class VisualizationScene: SKScene {
    
    var startTime: TimeInterval = 0.0
    var musicAnalysisVM = MusicAnalysisViewModel.shared
    var playVM = PlayerViewModel.shared
    var offsetToBeVisualized:Bool = false
    var timerDelegate: VisualizationTimerDelegate? = nil
    var beatsBeforeOffsetNeeded:Bool = false
    var centerX:Double = 0
    var centerY:Double = 0
    var visualizationValues: [VisualizationElement] = []
    var visualizationType:VisualizationType = VisualizationType.Bubble
    var visualization:Visualization = Visualization()
    let delay:Double = 0.5
    
  
    override func didMove(to view: SKView) {

        visualization = Visualization()
        musicAnalysisVM = MusicAnalysisViewModel.shared
        visualizationType = musicAnalysisVM.visualizationType
        visualizationValues = musicAnalysisVM.visualizationValues
        centerX = frame.midX - 20
        centerY = frame.midY + 100
        
        switch visualizationType {
        case .Bubble:
            visualization = VisualizationBubbles(visualitationValues: visualizationValues, centerX: centerX, centerY: centerY)
            break
        case .Lines:
            visualization = VisualizationLines(visualitationValues: visualizationValues, centerX: centerX, centerY: centerY)
            break
        case .Loudness:
            visualization = VisualizationLoudness(visualitationValues: visualizationValues, centerX: centerX, centerY: centerY)
            break
        }
            
    }
    
//    private func initalizeValues() {
//
//        visualizationType = musicAnalysisVM.visualizationType
//
//        switch visualizationType {
//        case .Bubble:
//            initalizeBubble()
//            break
//        case .Lines:
//            break
//        }
//    }
    
    private func resetScene(_ currentTime:Double) {
        print("Scene reset")
        self.startTime = currentTime
        playVM.songForwarded = false
        beatsBeforeOffsetNeeded = true
        playVM.timeOnHold = true
        
        visualizationType = musicAnalysisVM.visualizationType
        
        switch visualizationType {
        case .Bubble:
            visualization = VisualizationBubbles( visualitationValues: visualizationValues, centerX: centerX, centerY: centerY)
            break
        case .Lines:
            visualization = VisualizationLines(visualitationValues: visualizationValues, centerX: centerX, centerY: centerY)
            break
        case .Loudness:
            visualization = VisualizationLoudness(visualitationValues: visualizationValues, centerX: centerX, centerY: centerY)
            break
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if (playVM.isPlayling) {
            if self.startTime == 0.0 { self.startTime = currentTime }
            if (playVM.songForwarded) {
                resetScene(currentTime)
            }
            
            let timePassed = currentTime - self.startTime + playVM.offset - self.delay
            let roundedTimer = round(timePassed*100)/100
            
//            print(roundedTimer)
            
            // delegate time for view-updates
            self.passTime(time:roundedTimer)
            
            if(musicAnalysisVM.checkIfBeatDetected(time: roundedTimer)) {

                if (beatsBeforeOffsetNeeded) {
                    visualizeBeatsBeforeOffset(roundedTimer)
                } else {
                    let numBeat = musicAnalysisVM.counterBeatsDetected
                    
                    if (numBeat < visualizationValues.count) {
                        let visualizationData = visualizationValues[numBeat]
                        visualization.visualizeBeat(scene:self, step: numBeat, visualisationData: visualizationData)
                    }
                                        
                }

            }
        }
        
    }
    
   
    
    private func visualizeBeatsBeforeOffset(_ roundedTimer: Double) {
        
        removeAllChildren()

        var offsetBeatNum = musicAnalysisVM.numBeatsPerTimestamp[roundedTimer]
        
        if let numBeats = offsetBeatNum {
            musicAnalysisVM.counterBeatsDetected = numBeats
            for i in 0..<numBeats {
                visualization.visualizeBeat(scene:self, step: i, visualisationData: visualizationValues[i])
            }

        } else {
            let previousTime = round((roundedTimer - 0.01)*100)/100
            offsetBeatNum = musicAnalysisVM.numBeatsPerTimestamp[previousTime]
            musicAnalysisVM.counterBeatsDetected = offsetBeatNum!
            for i in 0..<offsetBeatNum! {
                visualization.visualizeBeat(scene:self, step: i, visualisationData: visualizationValues[i])
            }
        }

        beatsBeforeOffsetNeeded = false
        

    }
    

    

}



extension VisualizationScene {

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Gets the first touch object in the set of touches
        guard let touch = touches.first else { return }
        // Gets the position of the touch in the game scene
        let touchPosition = touch.location(in: self)

        for child in self.children {
            
            let dist = CGPointDistanceSquared(from: child.position, to: touchPosition)
            
            if (dist < 400) {
                
//                var angle = angleBetweenPoints(child.position, touchPosition)
                let newPoint = newPointAfterMoving(child.position, angle: angleBetweenPoints(child.position, touchPosition), distance: -50)
//                child.position = newPoint
                let moveAnimation = SKAction.move(to: newPoint, duration: 0.5)
                child.run(moveAnimation)
//                var scaleFactor = ((400 - dist)/200) + 1
//
//                let scaleAnimation = SKAction.scale(by: scaleFactor, duration: 0.5)
//                child.run(scaleAnimation)
                
                
            }
            
        }
        
//        // 1. Checks if there is a SKShapeNode where the player touched.
//        if let selectedNode = nodes(at: touchPosition).first as? SKShapeNode {
//            // 2. If so, calls a function to destroy the node
////            selectedNode.position.x += 50
////            selectedNode.position.y += 50
//
//            selectedNode.physicsBody = SKPhysicsBody(circleOfRadius: 10)
//            selectedNode.physicsBody?.affectedByGravity
//
//        }
        
    }
    
    private func destroy(_ square: SKShapeNode) {
            square.removeFromParent()
        }

//    func CGPointDistance(from: CGPoint, to: CGPoint) -> CGFloat {
//        return sqrt(CGPointDistanceSquared(from: from, to: to))
//        Distance
//    }
    
    func CGPointDistanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }
    
    func angleBetweenPoints(_ point1: CGPoint, _ point2: CGPoint) -> Angle {
            return point1.angle(to: point2)
        }
        
    func newPointAfterMoving(_ point: CGPoint, angle: Angle, distance: CGFloat) -> CGPoint {
        return point.move(by: angle, distance: distance)
    }
    
    
    
}

extension VisualizationScene {
    
    private func passTime(time:Double) {
        if var timerDelegate = self.timerDelegate {
            timerDelegate.passTime(time: time)
        }
    }
    
}

extension CGPoint {
    func angle(to point: CGPoint) -> Angle {
        let deltaX = point.x - self.x
        let deltaY = point.y - self.y
        let radians = atan2(deltaY, deltaX)
        return Angle(radians: Double(radians))
    }
    
    func move(by angle: Angle, distance: CGFloat) -> CGPoint {
        let deltaX = cos(CGFloat(angle.radians)) * distance
        let deltaY = sin(CGFloat(angle.radians)) * distance
        return CGPoint(x: self.x + deltaX, y: self.y + deltaY)
    }
}

