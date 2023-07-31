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
        scene.size = CGSize(width: 600, height: 600)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        // 3. Using the SpriteView, show the game scene in your SwiftUI view
        //    You can even use modifiers!
        GeometryReader { geometry in
            SpriteView(scene: self.scene)
                .frame(width: 300, height: 300)
                .ignoresSafeArea()
        }.ignoresSafeArea()
    }
    
}


class VisualizationScene: SKScene {
    
    private var startTime: TimeInterval = 0.0
    private var musicAnalysisVM = MusicAnalysisViewModel.shared
    private var angle:Double = 0
        
    override func didMove(to view: SKView) {
//        angle = Float(2 * Double.pi) / Float(musicAnalysisVM.visualizationValues.count - 1)

        print("in Szene:", musicAnalysisVM.visualizationValues.count)
        angle = 2 * .pi / Double(musicAnalysisVM.visualizationValues.count)
        print(angle)
        
        for i in 0..<musicAnalysisVM.visualizationValues.count {
            var Circle = drawCircle(radius: 10, posX: getX(angle: angle, step: i, radius: 100) + frame.midX , posY: getY(angle: angle, step: i, radius: 100) + frame.midY, fillColor: SKColor.white)
            self.addChild(Circle)
        }

        

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

            var Circle = drawCircle(radius: 10, posX: getX(angle: angle, step: numBeat, radius: 100) + frame.midX, posY: getY(angle: angle, step: numBeat, radius: 100) + frame.midY, fillColor: SKColor.random)


            self.addChild(Circle)
        }
        

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
