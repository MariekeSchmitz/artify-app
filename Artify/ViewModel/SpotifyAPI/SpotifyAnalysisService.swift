//
//  SpotifyAnalysisService.swift
//  Artify
//
//  Created by Marieke Schmitz on 19.06.23.
//

import Foundation

class SpotifyAnalysisService {
    
    static var shared:SpotifyAnalysisService = SpotifyAnalysisService()
    let urlService = SpotifyURLService.shared

    func getAudioFeatures(trackId:String) async -> AudioFeatures? {
        return await getData(urlRequest: urlService.getURLforRequest(type: .audioFeatures, id: trackId))
    }
    
    func getAudioAnalysis(trackId:String) async -> AudioAnalysis? {
        return await getData(urlRequest: urlService.getURLforRequest(type: .audioAnalysis, id: trackId))
    }
    
    
    
    func getData<T:Decodable>(urlRequest:URLRequest?) async -> T?{
        var decodedData:T?
        print(T.self)

        if let urlUnwrapped = urlRequest {
            print(urlUnwrapped)
            do {
                let (data, response) = try await URLSession.shared.data(for: urlUnwrapped)
                print(response)
                guard (response as? HTTPURLResponse)?.statusCode == 200 else { return nil }
                
                decodedData = try JSONDecoder().decode(T.self, from: data)
            } catch let error {
                print("Error fetching: ", error)
            }
            
        }
        return decodedData
    }

}
