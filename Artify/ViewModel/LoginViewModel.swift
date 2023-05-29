//
//  LoginViewModel.swift
//  Artify
//
//  Created by Marieke Schmitz on 27.05.23.
//

import Foundation

class LoginViewModel: ObservableObject{
    
    let spotifyService: SpotifyURLService = SpotifyURLService.shared
    @Published var loginState: LoginState = LoginState.shared

    func getAccessTokenURL() -> URLRequest? {
        return spotifyService.getAccessTokenURL()
    }
}
