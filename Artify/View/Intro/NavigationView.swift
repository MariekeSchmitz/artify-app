//
//  NavigationView.swift
//  Artify
//
//  Created by Marieke Schmitz on 18.06.23.
//

import SwiftUI

struct NavigationView: View {
    
    @State var introTimePassed = false
    @State var playViewOn = false
    @StateObject var loginVM: LoginViewModel = LoginViewModel.shared
    @State var webViewPresent = false
    
    var body: some View {
        
        if (playViewOn) {
            MainView()
        } else {
            ZStack{
                Color.darkGrayBG.ignoresSafeArea()
                VStack {
                    IntroView().padding(.bottom, introTimePassed ? 300 : 0).task(delayIntro)
                    
                    if (introTimePassed && !loginVM.loginState.loggedIn) {
                        
                        HStack {
                            Button("Login to Spotify") {
                                webViewPresent.toggle()
                            }.buttonStyle(RoundedButton())
                                .sheet(isPresented: $webViewPresent, onDismiss: {
                                }){
                                    SpotifyWebView(loginVM:loginVM, webViewPresent: $webViewPresent, playViewOn: $playViewOn)
                                }
                                .ignoresSafeArea()
                                .navigationTitle("Login to Spotify")
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    }
                }
            }
        }
    }
    
    private func delayIntro() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        withAnimation {
            introTimePassed = true
        }
    }
}


struct IntroView: View {
    
    var body: some View {
        HStack (spacing:0) {
            VStack(spacing:0) {
                Text("let").frame(maxWidth: .infinity, alignment: .trailing).frame(height:50)
                Text("music").frame(maxWidth: .infinity, alignment: .trailing).frame(height:50)
                Text("create").frame(maxWidth: .infinity, alignment: .trailing).frame(height:50)
                Text("art").frame(maxWidth: .infinity, alignment: .trailing).frame(height:50)
            }
            .foregroundColor(Color.white)
            .font(Font.custom("DMSerifDisplay-Regular", size: 55)).foregroundColor(.white)
            Image("artify")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .scaledToFit()
                .frame(width: 100, height: 170)
        }
    }
    
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView()
    }
}
