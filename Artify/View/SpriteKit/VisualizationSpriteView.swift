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
    
    var scene: VisualizationSceneC
    var spriteView:SpriteView
    
    init() {
        scene = VisualizationSceneC()
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
//        let scale = self.scene.view?.window?.screen.scale
        UIGraphicsBeginImageContextWithOptions(bounds!.size, false, 10)
        self.scene.view?.drawHierarchy(in: CGRect(origin: CGPoint(x: 0, y: 0), size: bounds!.size), afterScreenUpdates: true)

        let screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        UIImageWriteToSavedPhotosAlbum(screenshotImage!, nil, nil, nil)
    }
    
}







