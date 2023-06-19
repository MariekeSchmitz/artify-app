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
    
    

}
