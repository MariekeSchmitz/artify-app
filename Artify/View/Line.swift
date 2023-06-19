//
//  Line.swift
//  Artify
//
//  Created by Marieke Schmitz on 18.06.23.
//

import SwiftUI

struct Line: View {
    var body: some View {
        Text("„Lorem ipsum dolor sit amet, consectetur adipisici elit, …“ ist ein Blindtext, der nichts bedeuten soll, sondern als Platzhalter im Layout verwendet wird, um einen Eindruck vom fertigen Dokument zu erhalten.")
            .font(Font.custom("DMSerifDisplay-Regular", size: 32))
            .lineSpacing(0)
            
            
    }
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        Line()
    }
}
