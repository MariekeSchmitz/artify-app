//
//  Shapes.swift
//  Artify
//
//  Created by Marieke Schmitz on 31.07.23.
//

import Foundation
import SpriteKit

func drawCircle(radius:CGFloat, posX:CGFloat, posY:CGFloat, fillColor:SKColor) -> SKShapeNode {
    
    var Circle = SKShapeNode(circleOfRadius: radius)
    
    Circle.position = CGPointMake(posX, posY)
    Circle.fillColor = fillColor

    return Circle
    
}


func getX(angle: Double, step:Int, radius:Double) -> CGFloat {

    let angleForStep = angle * Double(step)
    let x = radius * cos(CGFloat(angleForStep))

    return x
}

func getY(angle: Double, step:Int, radius:Double) -> CGFloat {

    let angleForStep = angle * Double(step)
    let y = radius * sin(CGFloat(angleForStep))

    return y
}

