//
//  LoginView.swift
//  Artify
//
//  Created by Marieke Schmitz on 27.05.23.
//

import Foundation

import SwiftUI
import WebKit


struct LoginView: View {
    
//    @EnvironmentObject var network: Network
//    @ObservedObject var viewmodel:LoginViewModel = LoginViewModel()
    @State var webViewPresent = false
    @Binding var path:NavigationPath
    @ObservedObject var loginVM:LoginViewModel
    
    var body: some View{
        
        HStack {
            
            Button("Login to Spotify") {
                webViewPresent.toggle()
            }
            
            .sheet(isPresented: $webViewPresent, onDismiss: {
                path = NavigationPath()
            }){
                SpotifyWebView(loginVM:loginVM, webViewPresent: $webViewPresent)
            }
            .ignoresSafeArea()
            .navigationTitle("Login to Spotify")
            .navigationBarTitleDisplayMode(.inline)
            
            
//            NavigationView {
//                NavigationLink(destination: MusicLibraryView()) {
//                    Text("Get started")
//                }
//            }

        }
    }
    
}



//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
////            .environmentObject(Network())
//
//    }
//}

