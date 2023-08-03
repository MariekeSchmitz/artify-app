//
//  VisualizationLines.swift
//  Artify
//
//  Created by Marieke Schmitz on 03.08.23.
//

import Foundation
import SpriteKit


class VisualizationLines : Visualization{
    
    private var timbreRadius:Double = 0
    private var prevPitchLinePos = [CGPoint](repeating:CGPoint(), count: 12)
    private var pitchColors = [SKColor](repeating:SKColor(), count: 12)
    private var prevTimbreLinePos = [CGPoint](repeating:CGPoint(), count: 12)
    private var size = 1.0
    
    override init(visualitationValues:[VisualizationElement], centerX:Double, centerY:Double) {
        super.init(visualitationValues: visualitationValues, centerX: centerX, centerY: centerY)
        
        angle = 2 * .pi / Double(visualitationValues.count) * 5
        radius = 350
        timbreRadius = radius/3
        
        for i in 0..<pitchRadius.count {
            pitchRadius[i] = radius/12 * Double(i)
        }
    }
    
    override func visualizeBeat(scene:VisualizationScene, step:Int, visualisationData:VisualizationElement) {
        

        
 
            scene.addChild(circle)
        }
    }
}
