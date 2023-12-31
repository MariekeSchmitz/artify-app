//
//  Shapes.swift
//  Artify
//
//  Created by Marieke Schmitz on 31.07.23.
//

import Foundation
import SpriteKit



func drawCircle(radius:CGFloat, posX:CGFloat, posY:CGFloat, fillColor:SKColor = SKColor.white, strokeColor:SKColor = SKColor.white, outline:Bool = false, glow:Bool = false) -> SKShapeNode {
    
    let c = SKShapeNode(circleOfRadius: radius)
    
    c.position = CGPointMake(posX, posY)
    
    if outline {
        c.strokeColor = strokeColor
        c.lineWidth = 1
    } else if (glow) {
        c.fillColor = fillColor
        c.strokeColor = fillColor
        c.lineWidth = 1
    } else {
        c.fillColor = fillColor
        c.lineWidth = 0
    }
    
    return c
    
}

func drawLine(startPoint: CGPoint, endPoint: CGPoint, lineWidth: CGFloat = 1, lineColor: SKColor = SKColor.white) -> SKShapeNode {
    
    let newLine = SKShapeNode()
    let pathToDraw = CGMutablePath()
    pathToDraw.move(to: startPoint)
    pathToDraw.addLine(to: endPoint)
    
    newLine.path = pathToDraw
    newLine.strokeColor = lineColor
    newLine.lineWidth = lineWidth
    
    return newLine
}

func drawCurve(startPoint: CGPoint, endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint, lineWidth: CGFloat = 0.5, lineColor: SKColor = SKColor.white) -> SKShapeNode {
    
    let path = UIBezierPath()
    path.move(to: startPoint)
    path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    
    let curve = SKShapeNode(path: path.cgPath)
    curve.strokeColor = lineColor
    curve.lineWidth = lineWidth
    
    return curve
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

extension SKColor {
    static var whiteTransparent: SKColor {
        return SKColor(
            red: 1,
            green: 1,
            blue: 1,
            alpha: 0.3
        )
    }
}

