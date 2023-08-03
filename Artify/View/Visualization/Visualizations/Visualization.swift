//
//  Visualization.swift
//  Artify
//
//  Created by Marieke Schmitz on 03.08.23.
//


class Visualization {
    var musicAnalysisVM = MusicAnalysisViewModel.shared
    var playVM = PlayerViewModel.shared
    var angle:Double = 0
    var pitchRadius = [Double](repeating:0, count: 12)
    var radius:Double = 300
    var visualizationValues: [VisualizationElement] = []
    var centerX:Double = 0
    var centerY:Double = 0

    init() {
        
    }
    
    init(visualitationValues:[VisualizationElement], centerX:Double, centerY:Double) {
        self.visualizationValues = visualitationValues
        self.centerX = centerX
        self.centerY = centerY
    }
    
    func visualizeBeat(scene:VisualizationScene, step:Int, visualisationData:VisualizationElement) {
    }
    
    
}