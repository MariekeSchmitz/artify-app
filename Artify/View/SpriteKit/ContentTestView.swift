//
//  ContentTestView.swift
//  Artify
//
//  Created by Marieke Schmitz on 31.07.23.
//

import SwiftUI
import SpriteKit

struct ContentTestView:View {
    
    // 2. Create a variable that will initialize and host the Game Scene
    var scene: SKScene {
        let scene = VisualizationScene()
        scene.size = CGSize(width: 216, height: 216)
        scene.scaleMode = .fill
        return scene
    }
    
    var body: some View {
        // 3. Using the SpriteView, show the game scene in your SwiftUI view
        //    You can even use modifiers!
        SpriteView(scene: self.scene)
            .frame(width: 256, height: 256)
            .ignoresSafeArea()
    }
    
}


class VisualizationScene: SKScene {
    
    private var lastTimeSpawnedSquare: TimeInterval = 0.0
    private var startTime: TimeInterval = 0.0
    
    override func didMove(to view: SKView) {
        print("You are in the game scene!")
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if self.startTime == 0.0 { self.startTime = currentTime }
        
        let timePassed = currentTime - self.startTime
        print(timePassed)
        
        
//        let timePassed = currentTime - self.lastTimeSpawnedSquare
//
//        if timePassed >= 2 {
//            print("2 seconds passed")
//            // Reseting the timer
//            self.lastTimeSpawnedSquare = currentTime
//        }
    }
}
