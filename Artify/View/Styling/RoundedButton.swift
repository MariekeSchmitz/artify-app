//
//  RoundedButton.swift
//  Artify
//
//  Created by Marieke Schmitz on 22.06.23.
//

import SwiftUI

struct RoundedButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundStyle(.white)
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                            .stroke(Color.white, lineWidth: 1)
                            .frame(width: 180, height: 45)
                    )
            .font(Font.custom("Poppins-Regular", size: 15))
            
    }
}
