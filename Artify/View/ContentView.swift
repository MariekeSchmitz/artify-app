//
//  ContentView.swift
//  Artify
//
//  Created by Marieke Schmitz on 12.05.23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @ObservedObject var lVM = LoginViewModel()
    
    var body:some View {
        if lVM.loginState.loggedIn {
            Text("Loggedin")
        } else {
            Text("Loggedout")
        }
        
        Button("toggel"){
            lVM.loginState.loggedIn.toggle()
        }
    }
    
    
    
}

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
