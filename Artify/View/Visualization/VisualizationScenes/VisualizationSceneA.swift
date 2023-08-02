//
//  VisualizationSceneA.swift
//  Artify
//
//  Created by Marieke Schmitz on 01.08.23.
//

import Foundation
import SwiftUI
import SpriteKit

class VisualizationSceneA: SKScene {
    
    private var startTime: TimeInterval = 0.0
    private var musicAnalysisVM = MusicAnalysisViewModel.shared
    private var playVM = PlayerViewModel.shared
    private var angle:Double = 0
    private var pitchRadius = [Double](repeating:0, count: 12)
    private var radius:Double = 300
    private var offsetToBeVisualized:Bool = false
    var timerDelegate: VisualizationTimerDelegate? = nil

        
    override func didMove(to view: SKView) {

//        self.anchorPoint
        let values = musicAnalysisVM.visualizationValues
        
        angle = 2 * .pi / Double(values.count)
        for i in 0..<pitchRadius.count {
            pitchRadius[i] = radius/12 * Double(i)
        }
        
        offsetToBeVisualized = (playVM.offset != 0)
        
        
        
        
//        for i in 0..<values.count {
//
//            if (values[i].sectionChange) {
//                var circle = drawCircle(radius: 100, posX: getX(angle: angle, step: i, radius: 100) + frame.midX , posY: getY(angle: angle, step: i, radius: 100) + frame.midY, fillColor: SKColor.white)
//                    self.addChild(circle)
//            }
//
//            let pitches = values[i].pitches
//            print(pitches)
//            for j in 0..<pitches.count {
//                var circle = drawCircle(radius: 10 * pitches[j], posX: getX(angle: angle, step: i, radius: pitchRadius[j]) + frame.midX , posY: getY(angle: angle, step: i, radius: pitchRadius[j]) + frame.midY, fillColor: SKColor.random)
//                    self.addChild(circle)
//            }
            
            
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if (playVM.songForwarded) {
            playVM.songForwarded = false
            let nextScene = VisualizationSceneA(size: self.scene!.size)
            nextScene.scaleMode = self.scaleMode
            nextScene.backgroundColor = self.backgroundColor
            self.view?.presentScene(nextScene, transition: SKTransition.fade(with: UIColor.black, duration: 1.5))
        } 
        
        if self.startTime == 0.0 { self.startTime = currentTime }
        
        let timePassed = currentTime - self.startTime + playVM.offset
        let roundedTimer = round(timePassed*100)/100
        
        self.passTime(time:roundedTimer)
        
        
        if(musicAnalysisVM.checkIfBeatDetected(time: roundedTimer)) {

            if (offsetToBeVisualized) {
                
                var offsetBeatNum = musicAnalysisVM.numBeatsPerTimestamp[roundedTimer]
                
                if let numBeats = offsetBeatNum {
                    musicAnalysisVM.counterBeatsDetected = numBeats
                    visualizeBeatsBeforeOffset(offsetBeatNum: numBeats)

                } else {
                    let previousTime = round((roundedTimer - 0.01)*100)/100
                    offsetBeatNum = musicAnalysisVM.numBeatsPerTimestamp[previousTime]
                    musicAnalysisVM.counterBeatsDetected = offsetBeatNum!
                    visualizeBeatsBeforeOffset(offsetBeatNum: offsetBeatNum!)

                }
                
                offsetToBeVisualized = false
                
            } else {
                
                
                let numBeat = musicAnalysisVM.counterBeatsDetected
                let visualizationData = musicAnalysisVM.visualizationValues[numBeat]
                
                visualizeBeat(step: numBeat, visualisationData: visualizationData)
            }

//            if (visualizationData.sectionChange) {
//                var circle = drawCircle(radius: 100, posX: getX(angle: angle, step: numBeat, radius: 100) + frame.midX , posY: getY(angle: angle, step: numBeat, radius: 100) + frame.midY, fillColor: SKColor.randomTransparent)
//                    self.addChild(circle)
//            }
//
//            let pitches = visualizationData.pitches
//            print(pitches)
//            for j in 0..<pitches.count {
//                var circle = drawCircle(radius: 10 * pitches[j], posX: getX(angle: angle, step: numBeat, radius: pitchRadius[j]) + frame.midX , posY: getY(angle: angle, step: numBeat, radius: pitchRadius[j]) + frame.midY, fillColor: SKColor.random)
//                    self.addChild(circle)
//            }


        }
        

    }
    
    func visualizeBeatsBeforeOffset(offsetBeatNum: Int) {
        
        let visualizationValues = musicAnalysisVM.visualizationValues
        for i in 0..<offsetBeatNum {
            visualizeBeat(step: i, visualisationData: visualizationValues[i])
        }
        
    }
    
    func visualizeBeat(step:Int, visualisationData:VisualizationElement) {
        if (visualisationData.sectionChange) {
            var circle = drawCircle(radius: 100, posX: getX(angle: angle, step: step, radius: 100) + frame.midX , posY: getY(angle: angle, step: step, radius: 100) + frame.midY, fillColor: SKColor.randomTransparent)
                self.addChild(circle)
        }
        
        let pitches = visualisationData.pitches
        for j in 0..<pitches.count {
            var circle = drawCircle(radius: 10 * pitches[j], posX: getX(angle: angle, step: step, radius: pitchRadius[j]) + frame.midX , posY: getY(angle: angle, step: step, radius: pitchRadius[j]) + frame.midY, fillColor: SKColor.random)
                self.addChild(circle)
        }
    }
    

}



extension VisualizationSceneA {

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

extension VisualizationSceneA {
    
    
    private func passTime(time:Double) {
        if var timerDelegate = self.timerDelegate {
            timerDelegate.passTime(time: time)
        }
    }
    
}

