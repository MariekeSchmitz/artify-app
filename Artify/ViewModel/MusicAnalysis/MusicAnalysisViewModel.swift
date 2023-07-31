//
//  DataAnalysisViewModel.swift
//  Artify
//
//  Created by Marieke Schmitz on 19.06.23.
//

import Foundation

class MusicAnalysisViewModel : ObservableObject {
    
    static let shared = MusicAnalysisViewModel()
    let analysisService = SpotifyAnalysisService.shared
    var audioFeatures: AudioFeatures = AudioFeatures()
    var audioAnalysis: AudioAnalysis = AudioAnalysis()
    var songTimer: Double = 0.00

    @Published var visualizationValues:[VisualizationElement] = []
    var numBeatsPerTimestamp = [Double:Int]()
    var beatDetectedPerTimeStamp = [Double:Bool]()

    
    var counterBeatsDetected: Int = 0
    

//    var timerVisualization: Timer?
    
//    let timer = Timer
//        .publish(every: 0.01, on: .main, in: .common)
//        .autoconnect()
    
    
//    func setupTimer () {
//
//        if let t = timerVisualization {
//            t.invalidate()
//        }
//
//        counterBeatsDetected = 0
//
//        timerVisualization = Timer.scheduledTimer(
//                timeInterval: 0.01,
//                target: self,
//                selector: #selector(handleTimerExecution),
//                userInfo: nil,
//                repeats: true)
//    }
    
    
    private func setupVisualizationData() {
        
        var numBeats = 0
        var currentSegmentCounter = 0
        var currentSectionCounter = 0
        counterBeatsDetected = 0
        
        visualizationValues = [VisualizationElement](repeating: VisualizationElement(), count: audioAnalysis.beats.count)
        numBeatsPerTimestamp = [Double:Int]()
        
        for beat in audioAnalysis.beats {
            
            visualizationValues[numBeats] = VisualizationElement()
            
            currentSegmentCounter = getPitchData(beatStart: beat.start, numBeats: numBeats, currentSegmentCounter: currentSegmentCounter)
            currentSectionCounter = getSectionData(beatStart: beat.start, numBeats: numBeats, currentSectionCounter: currentSectionCounter)
            
            numBeats += 1
            
            let roundedBeatStart = round(beat.start * 100) / 100.00
            numBeatsPerTimestamp[roundedBeatStart] = numBeats
            beatDetectedPerTimeStamp[roundedBeatStart] = false
        }
        
        print(visualizationValues)
        print(visualizationValues.count)
        
//        let sortedByValueDictionary = numBeatsPerTimestamp.sorted { $0.1 < $1.1 }
//
//        print(sortedByValueDictionary)
//
    }
    
    private func getPitchData(beatStart:Double, numBeats:Int, currentSegmentCounter:Int) -> Int{
        
        let segments = audioAnalysis.segments
        
        // segments sorted by time
        for i in currentSegmentCounter..<segments.count {
            
            let segment = segments[i]
            let segmentStart = segment.start
            let segmentEnd = segment.start + segment.duration
            
            // if beat lies within segment, add pitches from this segment to visualitationValues
            if (beatStart >= segmentStart && beatStart < segmentEnd) {
                
                let pitches = segment.pitches
                visualizationValues[numBeats].pitches = pitches
                
                // return current segmentIndex as new starting point for next segment search
                return i
            }
        }
        
        return currentSegmentCounter
        
    }
    
    private func getSectionData(beatStart:Double, numBeats:Int, currentSectionCounter:Int) -> Int {
        
        let sections = audioAnalysis.sections
        
        for i in currentSectionCounter..<sections.count {
            
            let section = sections[i]
            let sectionStart = section.start
            let sectionEnd = section.start + section.duration
            
            // if beat lies within segment, add pitches from this segment to visualitationValues
            if (beatStart >= sectionStart && beatStart < sectionEnd) {
                
                visualizationValues[numBeats].sectionCounter = i
                visualizationValues[numBeats].sectionChange = (i != currentSectionCounter)
                
                // return current segmentIndex as new starting point for next segment search
                return i
            }
        }
        
        return currentSectionCounter
        
    }
    
//    @objc private func handleTimerExecution() {
//
//        songTimer += 0.01
//        let roundedTimer = round(songTimer*100)/100
////        if checkBeats(time: roundedTimer) {
////            print("beat detected")
//////            addToVisualizationValues(index: counterBeatsDetected)
////            colorToggle.toggle()
////        }
//        checkIfBeatDetected(time: roundedTimer)
//
//    }
    
    
    
    func checkIfBeatDetected(time:Double) -> Bool{
        
        let previousTime = round((time - 0.01)*100)/100

        if (numBeatsPerTimestamp.keys.contains(time)) {
            
            if (!(beatDetectedPerTimeStamp[time]!)) {
                beatDetectedPerTimeStamp[time] = true
                counterBeatsDetected += 1
                
                print("beat detected: \(time)")
                print("total num beats detected: \(counterBeatsDetected)")
                
                return true
            }
        
            
            
        } else if (numBeatsPerTimestamp.keys.contains(previousTime)) {

            if (!(beatDetectedPerTimeStamp[previousTime]!)) {
                beatDetectedPerTimeStamp[previousTime] = true
                counterBeatsDetected += 1

                print("beat detected: \(previousTime)")
                print("total num beats detected: \(counterBeatsDetected)")

                return true
            }
        }
        

    
        return false
        
//        print("______")
//
//        for v in visualizationValues {
//            print(v.beatPlayed)
//        }
//
//        print("______")

        
//        let beats = audioAnalysis.beats
//        for beat in beats {
//            let roundedBeatStart = round(beat.start * 100) / 100.00
//            if roundedBeatStart == time {
//                counterBeatsDetected += 1
//                return true
//            }
//        }
//        return false
    }
    
//    func addToVisualizationValues(index:Int) {
//        visualizationValues[index - 1] = audioAnalysis.beats[index - 1]
//        print(visualizationValues)
//    }
    
    
//    @MainActor
    func getTracksAudioFeatures(id: String) async {
        
//        Task {
            let features:AudioFeatures? = await analysisService.getAudioFeatures(trackId: id)
            if let f = features {
                self.audioFeatures = f
                print(self.audioFeatures)
            }
//        }
        
    }
    
//    @MainActor
    func getTracksAudioAnalysis(id: String) async {
        
//        Task {
            let analysis:AudioAnalysis? = await analysisService.getAudioAnalysis(trackId: id)
            if let a = analysis {
                self.audioAnalysis = a
                print(self.audioAnalysis)
            }
        
        setupVisualizationData()
        
//        }
        
    }
    
  
    
    
    
}
