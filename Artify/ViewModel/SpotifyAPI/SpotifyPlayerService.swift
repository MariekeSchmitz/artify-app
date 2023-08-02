//
//  SpotifyPlayerService.swift
//  Artify
//
//  Created by Marieke Schmitz on 31.05.23.
//

import Foundation

class SpotifyPlayerService {
    
    static var shared:SpotifyPlayerService = SpotifyPlayerService()
    let urlService = SpotifyURLService.shared
    
    func resumeTrack() {
        sendURLRequest(urlRequest:urlService.getURLforRequest(type: .resumeTrack))
    }
    
    func playTrack(trackURI:String) {
        sendURLRequest(urlRequest:urlService.getURLforRequest(type: .playTrack, data:trackURI))
    }
    
    func seekToPositionInTrack(time_ms:String) {
        sendURLRequest(urlRequest:urlService.getURLforRequest(type: .seekPosInTrack, data:time_ms))
    }
    
    func pauseTrack() {
        sendURLRequest(urlRequest:urlService.getURLforRequest(type: .pauseTrack))
    }
    
    func playNextTrack() {
        sendURLRequest(urlRequest: urlService.getURLforRequest(type: .nextTrack))
    }
    
    func playPreviousTrack() {
        sendURLRequest(urlRequest:urlService.getURLforRequest(type: .previousTrack))
    }
    
    func sendURLRequest(urlRequest:URLRequest?) {
        
        if let urlUnwrapped = urlRequest {
            let dataTask = URLSession.shared.dataTask(with: urlUnwrapped) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else { return }
                print(response)
                
                if response.statusCode == 200 {
                    guard let data = data else { return }
                }
            }
            dataTask.resume()
        }
        
    }
    
}
