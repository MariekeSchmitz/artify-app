//
//  ContentTestView.swift
//  Artify
//
//  Created by Marieke Schmitz on 31.07.23.
//

import SwiftUI
import SpriteKit
import UIKit

struct VisualizationSpriteView:View {
    
    // 2. Create a variable that will initialize and host the Game Scene
    var scene: SKScene {
        let scene = VisualizationScene()
        scene.size = CGSize(width: 1000, height: 1000)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = UIColor.black
        return scene
    }
    
    var body: some View {
        // 3. Using the SpriteView, show the game scene in your SwiftUI view
        //    You can even use modifiers!
        GeometryReader { geo in
            SpriteView(scene: self.scene)
                .frame(width: geo.size.width+50, height: geo.size.height+50)
                .ignoresSafeArea()
            
        }
        
            
                

    }
    
}




class VisualizationScene: SKScene {
    
    private var startTime: TimeInterval = 0.0
    private var musicAnalysisVM = MusicAnalysisViewModel.shared
    private var angle:Double = 0
    private var pitchRadius = [Double](repeating:0, count: 12)
    private var radius:Double = 300
        
    override func didMove(to view: SKView) {

        let values = musicAnalysisVM.visualizationValues
        
        angle = 2 * .pi / Double(values.count)
        for i in 0..<pitchRadius.count {
            pitchRadius[i] = radius/12 * Double(i)
        }
        
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
            
            
            
        

        

        print("You are in the game scene!")
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if self.startTime == 0.0 { self.startTime = currentTime }
        
        let timePassed = currentTime - self.startTime
        let roundedTimer = round(timePassed*100)/100
        
        print(roundedTimer)
        print(angle)
        
        if(musicAnalysisVM.checkIfBeatDetected(time: roundedTimer)) {

            let numBeat = musicAnalysisVM.counterBeatsDetected
            let visualizationData = musicAnalysisVM.visualizationValues[numBeat]
            
            
            if (visualizationData.sectionChange) {
                var circle = drawCircle(radius: 100, posX: getX(angle: angle, step: numBeat, radius: 100) + frame.midX , posY: getY(angle: angle, step: numBeat, radius: 100) + frame.midY, fillColor: SKColor.randomTransparent)
                    self.addChild(circle)
            }
            
            let pitches = visualizationData.pitches
            print(pitches)
            for j in 0..<pitches.count {
                var circle = drawCircle(radius: 10 * pitches[j], posX: getX(angle: angle, step: numBeat, radius: pitchRadius[j]) + frame.midX , posY: getY(angle: angle, step: numBeat, radius: pitchRadius[j]) + frame.midY, fillColor: SKColor.random)
                    self.addChild(circle)
            }


        }
        

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
            selectedNode.position.x += 50
            selectedNode.position.y += 50
            
            selectedNode.physicsBody = SKPhysicsBody(circleOfRadius: 10)
            selectedNode.physicsBody?.affectedByGravity

        }
    }
    
    private func destroy(_ square: SKShapeNode) {
            square.removeFromParent()
        }
    
}

extension SKColor {
    static var random: SKColor {
        return SKColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1.0
        )
    }
}

extension SKColor {
    static var randomTransparent: SKColor {
        return SKColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 0.3
        )
    }
}
