//
//  CircleVisualization.swift
//  Artify
//
//  Created by Marieke Schmitz on 28.07.23.
//

import SwiftUI

struct CircleVisualization: View {
    
    var radius:GLfloat = 0
    var values:[VisualizationElement] = [VisualizationElement]()
    
//    @Binding var counterBeatsDetected:Int
    @State var centerX:CGFloat = 0
    @State var centerY:CGFloat = 0
    @State var angle:Float = 0.0
    @State var pitchRadius = [GLfloat](repeating:0, count: 12)
    
    var vm = MusicAnalysisViewModel.shared
    @StateObject var vmP = MusicAnalysisViewModel.shared

    
    var body: some View {
        ZStack {
            
            ForEach(0..<vm.visualizationValues.count, id: \.self) { i in

                // Start of Section
                if (vm.visualizationValues[i].sectionChange) {
                    EquatableView(content: CircleElement(width: 200, height:  200, opacity: 0.1, color: Color.yellow, posX: getX(step: i, radius: radius), posY: getY(step: i, radius: radius), step: i, beatsDetected: $vmP.visualizationValues[i].beatPlayed))
                    
                }

                // Pitches
                let pitches = vm.visualizationValues[i].pitches
                ForEach(0..<12) { j in
                    EquatableView(content: CircleElement(width: 30 * pitches[j], height:  30 * pitches[j], opacity: 1, color: Color.random, posX: getX(step: i, radius: pitchRadius[j]), posY: getY(step: i, radius: pitchRadius[j]), step: i, beatsDetected: $vmP.visualizationValues[i].beatPlayed))
                }
                
                
//                CircleElement(width: 20, height:  20, opacity: 1, color: Color.yellow, posX: getX(step: i, radius: radius), posY: getY(step: i, radius: radius))
                
                
                


            }
        }.onAppear(){
            self.angle = Float(2 * Double.pi) / Float(values.count - 1)

            for i in 0..<pitchRadius.count {
                pitchRadius[i] = radius/12 * Float(i)
            }
        }
    }
    
    
    func getX(step:Int, radius:GLfloat) -> CGFloat {
//        var a = Float(2 * Double.pi) / Float(counterBeatsDetected)
        let t = radius * cos(angle * Float(step))
        return CGFloat(t)
    }
    
    func getY(step:Int, radius:GLfloat) -> CGFloat {
//        var a = Float(2 * Double.pi) / Float(counterBeatsDetected)
        let t = radius * sin(angle * Float(step))
        return CGFloat(t)
    }
    
    func getXInvert(step:Int) -> Float {
        let t = radius-50 * cos((360-angle) * Float(step))
        return t
    }
    
    func getYInvert(step:Int) -> Float {
        let t = radius-50 * sin((360-angle) * Float(step))
        return t
    }
    
    
}

struct CircleElement : View, Equatable{
    
    var width:Double
    var height:Double
    var opacity:Double
    var color:Color
    var posX:CGFloat
    var posY:CGFloat
    var step:Int
    
    @Binding var beatsDetected : Bool
    
    var body: some View {
        if(beatsDetected){
            GeometryReader { geometry in
                Rectangle()
                    .frame(width: width, height: height)
                    .foregroundColor(color)
                    .opacity(opacity)
                    .cornerRadius(500)
                    .position(x:posX, y: posY)
                    .offset(x: geometry.size.width/2, y: geometry.size.height/2)
            }
        
        }
        let _ = Self._printChanges()
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.beatsDetected == rhs.beatsDetected
        }
    
   
    
}

extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
//struct CircleVisualization_Previews: PreviewProvider {
//    static var previews: some View {
//        CircleVisualization()
//    }
//}

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1)
        )
    }
}

