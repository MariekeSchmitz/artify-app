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
    
  
    override func didMove(to view: SKView) {

        visualization = Visualization()
        musicAnalysisVM = MusicAnalysisViewModel.shared
        visualizationValues = musicAnalysisVM.visualizationValues
        centerX = frame.midX - 20
        centerY = frame.midY + 100
        
        switch visualizationType {
        case .Bubble:
            visualization = VisualizationBubbles(visualitationValues: visualizationValues, centerX: centerX, centerY: centerY)
            break
        case .Lines:
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
        case .Lines:
            break
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if (playVM.isPlayling) {
            if self.startTime == 0.0 { self.startTime = currentTime }
            if (playVM.songForwarded) {
                resetScene(currentTime)
            }
            
            let timePassed = currentTime - self.startTime + playVM.offset
            let roundedTimer = round(timePassed*100)/100
            
            // delegate time for view-updates
            self.passTime(time:roundedTimer)
            
            if(musicAnalysisVM.checkIfBeatDetected(time: roundedTimer)) {

                if (beatsBeforeOffsetNeeded) {
                    visualizeBeatsBeforeOffset(roundedTimer)
                } else {
                    let numBeat = musicAnalysisVM.counterBeatsDetected
                    let visualizationData = visualizationValues[numBeat]
                    visualization.visualizeBeat(scene:self, step: numBeat, visualisationData: visualizationData)
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

extension VisualizationScene {
    
    private func passTime(time:Double) {
        if var timerDelegate = self.timerDelegate {
            timerDelegate.passTime(time: time)
        }
    }
    
}

