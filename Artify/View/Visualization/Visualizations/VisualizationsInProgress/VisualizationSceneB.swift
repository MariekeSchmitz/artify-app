//
//  VisualizationSceneB.swift
//  Artify
//
//  Created by Marieke Schmitz on 01.08.23.
//

import Foundation
import SwiftUI
import SpriteKit

class VisualizationSceneB: SKScene {
    
    private var startTime: TimeInterval = 0.0
    private var musicAnalysisVM = MusicAnalysisViewModel.shared
    private var angle:Double = 0
    private var timbreRadius:Double = 0
    private var pitchRadius = [Double](repeating:0, count: 12)
    private var prevPitchLinePos = [CGPoint](repeating:CGPoint(), count: 12)
    private var pitchColors = [SKColor](repeating:SKColor(), count: 12)
    
    private var prevTimbreLinePos = [CGPoint](repeating:CGPoint(), count: 12)
    private var stepsPerPitch = [Int](repeating: 0, count: 12)
    private var stepsPerTimbre = [Int](repeating: 0, count: 12)




    private var radius:Double = 350
        
    override func didMove(to view: SKView) {

        
//        self.anchorPoint
        let values = musicAnalysisVM.visualizationValues
        
        angle = 2 * .pi / Double(values.count)
        timbreRadius = radius/3

        
        if (values.count != 0 ) {
            for i in 0..<prevPitchLinePos.count {
                stepsPerPitch[i] = .random(in: 0..<values.count)
                stepsPerTimbre[i] = .random(in: 0..<values.count)

                let startXPitchLines = getX(angle: angle, step: stepsPerPitch[i], radius: radius) + frame.midX
                let startYPitchLines = getY(angle: angle, step: stepsPerPitch[i], radius: radius) + frame.midY
                
                let startXTimbreLines = getX(angle: angle, step: stepsPerTimbre[i], radius: timbreRadius) + frame.midX
                let startYTimbreLines = getY(angle: angle, step: stepsPerTimbre[i], radius: timbreRadius) + frame.midY
                
                prevPitchLinePos[i] = CGPoint(x: startXPitchLines, y:startYPitchLines)
                pitchColors[i] = SKColor.random
                
                prevTimbreLinePos[i] = CGPoint(x: startXTimbreLines, y:startYTimbreLines)
                
            }
        }

        
        
        
        for i in 0..<pitchRadius.count {
            pitchRadius[i] = radius/12 * Double(i)
        }
        
//        for i in 0..<values.count {
//
//            let pitches = values[i].pitches
//
//            for j in 0..<pitches.count {
//
//                var pitch = pitches[j]
//
//                if pitch > 0.9 {
//                    pitch += .random(in: 0...0.5)
//                }
//
//                radius = pitchRadius[j]
//
//                let newX = getX(angle: angle, step: i, radius: radius*1/2 + radius/2 * pitch) + frame.midX
//                let newY = getY(angle: angle, step: i, radius: radius*1/2 + radius/2 * pitch) + frame.midY
//
//                let line = drawLine(startPoint: prevPitchLinePos[j], endPoint: CGPoint(x: newX, y: newY), lineColor: pitchColors[j])
//                self.addChild(line)
//
//                prevPitchLinePos[j] = CGPoint(x: newX, y: newY)
//            }
//
//
//            let timbre = values[i].timbre
//
//            for j in 0..<timbre.count {
//
//                var timbre = pitches[j]
//
//                if timbre > 0.9 {
//                    timbre += .random(in: 0...0.1)
//                }
//
//                let newX = getX(angle: angle, step: i, radius: timbreRadius*1/2 + timbreRadius/2 * timbre) + frame.midX
//                let newY = getY(angle: angle, step: i, radius: timbreRadius*1/2 + timbreRadius/2 * timbre) + frame.midY
//
//                let line = drawLine(startPoint: prevTimbreLinePos[j], endPoint: CGPoint(x: newX, y: newY), lineColor: SKColor(white: 1, alpha: 0.3))
//                self.addChild(line)
//
//                prevTimbreLinePos[j] = CGPoint(x: newX, y: newY)
//            }
//
//
//        }
        

            
            
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if self.startTime == 0.0 { self.startTime = currentTime }
        let timePassed = currentTime - self.startTime
        let roundedTimer = round(timePassed*100)/100
        
        
        if(musicAnalysisVM.checkIfBeatDetected(time: roundedTimer)) {

            let numBeat = musicAnalysisVM.counterBeatsDetected
            let visualizationData = musicAnalysisVM.visualizationValues[numBeat]

            let pitches = visualizationData.pitches
            let timbre = visualizationData.timbre

            for j in 0..<pitches.count {

                var pitch = pitches[j]
                var timbre = pitches[j]

                if pitch > 0.9 {
                    pitch += .random(in: 0...0.5)
                }

                if timbre > 0.9 {
                    timbre += .random(in: 0...0.1)
                }
                
                radius = pitchRadius[j]

                let newXPitch = getX(angle: angle, step: stepsPerPitch[j], radius: radius*1/2 + radius/2 * pitch) + frame.midX
                let newYPitch = getY(angle: angle, step: stepsPerPitch[j], radius: radius*1/2 + radius/2 * pitch) + frame.midY

                var line = drawLine(startPoint: prevPitchLinePos[j], endPoint: CGPoint(x: newXPitch, y: newYPitch), lineColor: pitchColors[j])
                self.addChild(line)

                let newXTimbre = getX(angle: angle, step: stepsPerTimbre[j], radius: timbreRadius*1/2 + timbreRadius/2 * timbre) + frame.midX
                let newYTimbre = getY(angle: angle, step: stepsPerTimbre[j], radius: timbreRadius*1/2 + timbreRadius/2 * timbre) + frame.midY

                line = drawLine(startPoint: prevTimbreLinePos[j], endPoint: CGPoint(x: newXTimbre, y: newYTimbre), lineColor: SKColor(white: 1, alpha: 0.3))
                self.addChild(line)

                prevPitchLinePos[j] = CGPoint(x: newXPitch, y: newYPitch)
                prevTimbreLinePos[j] = CGPoint(x: newXTimbre, y: newYTimbre)

                if (j % 2 == 0) {
                    stepsPerPitch[j] += 1
                    stepsPerTimbre[j] += 1

                    if stepsPerPitch[j] == musicAnalysisVM.visualizationValues.count {
                        stepsPerPitch[j] = 0
                    }

                    if stepsPerTimbre[j] == musicAnalysisVM.visualizationValues.count {
                        stepsPerTimbre[j] = 0
                    }

                } else {
                    stepsPerPitch[j] -= 1
                    stepsPerTimbre[j] -= 1

                    if stepsPerPitch[j] < 0 {
                        stepsPerPitch[j] = musicAnalysisVM.visualizationValues.count - 1
                    }

                    if stepsPerTimbre[j] < 0 {
                        stepsPerTimbre[j] =  musicAnalysisVM.visualizationValues.count - 1
                    }
                }
                
                
            }
            
          

        }
        

    }
    

}



extension VisualizationSceneB {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Gets the first touch object in the set of touches
        guard let touch = touches.first else { return }
        // Gets the position of the touch in the game scene
        let touchPosition = touch.location(in: self)

        // 1. Checks if there is a SKShapeNode where the player touched.
        if let selectedNode = nodes(at: touchPosition).first as? SKShapeNode {
            // 2. If so, calls a function to destroy the node
//            selectedNode.position.x += 50
//            selectedNode.position.y += 50

            selectedNode.physicsBody = SKPhysicsBody(circleOfRadius: 10)
            selectedNode.physicsBody?.affectedByGravity

        }
        
    }
    
    private func destroy(_ square: SKShapeNode) {
            square.removeFromParent()
        }
    
}
