//
//  SettingsView.swift
//  Artify
//
//  Created by Marieke Schmitz on 29.05.23.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var settingsViewOn:Bool
    
    var body: some View {
        VStack{
            Text("Settingsview")
            Button("Zurück") {
                withAnimation {
                    settingsViewOn.toggle()
                }
               
            }
        }.background(Color.darkGrayBG)
        
    }
}

