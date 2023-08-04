//
//  ColorExtension.swift
//  Artify
//
//  Created by Marieke Schmitz on 15.06.23.
//

import Foundation
import SwiftUI

extension Color {
    
    static let darkGrayBG = Color("DarkGrayBG")
    
}

extension UIColor {
    func generateVariations(count: Int, step:CGFloat = 0.3) -> [UIColor] {
        var variations: [UIColor] = []
        let step: CGFloat = step
        
        for i in 0..<count {
            let red = self.rgbComponents.red + CGFloat(i) * step
            let green = self.rgbComponents.green + CGFloat(i) * step
            let blue = self.rgbComponents.blue + CGFloat(i) * step
            
            // Calculate the average of RGB components
            let averageComponent = (red + green + blue) / 3
            
            // Adjust each component equally based on the average
            let adjustedRed = max(0, red - CGFloat(i) * step * (averageComponent - 0.5))
            let adjustedGreen = max(0, green - CGFloat(i) * step * (averageComponent - 0.5))
            let adjustedBlue = max(0, blue - CGFloat(i) * step * (averageComponent - 0.5))
            
            let variation = UIColor(red: min(1, adjustedRed), green: min(1, adjustedGreen), blue: min(1, adjustedBlue), alpha: 1)
            variations.append(variation)
        }
        
        return variations
    }
    
    var rgbComponents: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b)
    }
    
    func getColorful() -> [UIColor] {
        return
        [UIColor(red: 232, green: 255, blue: 72, alpha: 1),
        UIColor(red: 106 , green: 255, blue: 96, alpha: 1),
        UIColor(red: 96, green: 255, blue: 202, alpha: 1),
        UIColor(red: 94, green: 249, blue: 255, alpha: 1),
        UIColor(red: 22, green: 138, blue: 255, alpha: 1),
        UIColor(red: 152, green: 77, blue: 255, alpha: 1),
        UIColor(red: 242, green: 65, blue: 255, alpha: 1),
        UIColor(red: 255, green: 60, blue: 147, alpha: 1),
        UIColor(red: 255, green: 82, blue: 65, alpha: 1),
        UIColor(red: 255, green: 136, blue: 62, alpha: 1),
        UIColor(red: 255, green: 172, blue: 0, alpha: 1),
        UIColor(red: 233, green: 255, blue: 212, alpha: 1)]
    }
}



