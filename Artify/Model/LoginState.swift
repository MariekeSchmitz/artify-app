//
//  TokenState.swift
//  Artify
//
//  Created by Marieke Schmitz on 27.05.23.
//

import Foundation

struct LoginState {
    
    var loggedIn:Bool = false
    var token:String = ""
    
    static let shared = LoginState()
    
//    init() {
//        
////        UserDefaults.standard.removeObject(forKey: "Authorization")
//        
//        if let token = UserDefaults.standard.string(forKey: "Authorization"){
//            self.token = token
//            loggedIn = true
//        }
//    }
    

}
