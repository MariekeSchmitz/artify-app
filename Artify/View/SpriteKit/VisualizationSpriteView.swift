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
    
    var scene: VisualizationSceneA
    var spriteView:SpriteView
    
    init() {
        scene = VisualizationSceneA()
        scene.size = CGSize(width: 1000, height: 1000)
        scene.scaleMode = .aspectFill
        scene.backgroundColor = UIColor.black
        
        spriteView = SpriteView(scene: scene)
    }
    
    var body: some View {

        GeometryReader { geo in
            spriteView
                .frame(width: geo.size.width+50, height: geo.size.height+50)
                .ignoresSafeArea()
        }

    }
    
    func takeScreenshot() {
        let bounds = self.scene.view?.bounds
        let scale = self.scene.view?.window?.screen.scale
        UIGraphicsBeginImageContextWithOptions(bounds!.size, false, 10)
        self.scene.view?.drawHierarchy(in: CGRect(origin: CGPoint(x: 0, y: 0), size: bounds!.size), afterScreenUpdates: true)

        var screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        UIImageWriteToSavedPhotosAlbum(screenshotImage!, nil, nil, nil)
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
