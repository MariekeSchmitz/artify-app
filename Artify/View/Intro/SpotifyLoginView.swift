//
//  SpotifyLoginView.swift
//  Artify
//
//  Created by Marieke Schmitz on 29.05.23.
//

import Foundation
import WebKit
import SwiftUI


struct SpotifyWebView: UIViewRepresentable {
    
    @ObservedObject var loginVM:LoginViewModel
    @Binding var webViewPresent: Bool
    @Binding var playViewOn: Bool
    
    private let webView = WKWebView()
    
    func makeUIView(context: Context) -> some UIView {
        webView.navigationDelegate = context.coordinator
        if let urlRequest = loginVM.getAccessTokenURL() {
            webView.load(urlRequest)
        }
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
    func didFinish() -> Void {
        guard let urlString = webView.url?.absoluteString else { return }
        
        var token : String = ""
        
        if urlString.contains("#access_token="){
            let range = urlString.range(of: "#access_token=")
            guard let index = range?.upperBound else { return }
            token = String(urlString[index...])
        }
        
        if !token.isEmpty {
            let range = token.range(of: "&token_type=Bearer")
            guard let index = range?.lowerBound else { return }
            
            token = String(token[..<index])
                        
            UserDefaults.standard.setValue(token, forKey: "Authorization")
            webView.removeFromSuperview()
            
            webViewPresent.toggle()
            playViewOn.toggle()

            loginVM.loginState.loggedIn.toggle()
            
            print(loginVM.loginState.loggedIn)
            print("Token: \(token)")
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(didFinish: didFinish)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        
        var didFinish: () -> Void

        init(didFinish: @escaping () -> Void) {
            self.didFinish = didFinish
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            didFinish()
        }
        
    }

}
