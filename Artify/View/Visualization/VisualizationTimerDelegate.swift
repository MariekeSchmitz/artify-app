//
//  VisualizationTimerDelegate.swift
//  Artify
//
//  Created by Marieke Schmitz on 02.08.23.
//

import Foundation

// read-only property
protocol VisualizationTimerDelegate {
    var time : Double { get }
    
    mutating func passTime(time: Double) -> Void
}
