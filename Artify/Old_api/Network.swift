////
////  Network.swift
////  Artify
////
////  Created by Marieke Schmitz on 27.05.23.
////
//
//import Foundation
//
//class Network: ObservableObject {
//
//    @Published var albums:ArtistAlbums = ArtistAlbums()
//
//    func getAlbums(){
//
//        print("Hi, we are in the albummssss")
//
//        var components = URLComponents()
//
//        //build url to get song
//        components.scheme = "https"
//        components.host = APIConstants.apiHost
//        components.path = "/v1/artists/0n94vC3S9c3mb2HyNAOcjg/albums"
//        guard let url = components.url else {return}
//
//        var urlRequest = URLRequest(url:url)
//        
//        // Header with token
//        let token:String = UserDefaults.standard.value(forKey: "Authorization") as! String
//        urlRequest.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
//        urlRequest.addValue("application/json ", forHTTPHeaderField: "Content-Type")
//
//        // HTTP Method
//        urlRequest.httpMethod = "GET"
//
//        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
//            if let error = error {
//                print("Request error: ", error)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse else { return }
//            if response.statusCode == 200 {
//                guard let data = data else { return }
//                print(data)
//                DispatchQueue.main.async {
//                    do {
//                        let decodedAlbums = try JSONDecoder().decode(ArtistAlbums.self, from: data)
//                        self.albums = decodedAlbums
//                        print(self.albums)
//                        print((self.albums.items)![0].name!)
//
//                    } catch let error {
//                        print("Error decoding: ", error)
//                    }
//                }
//            }
//        }
//
//        dataTask.resume()
//
//    }
//}
