//
//  ApiService.swift
//  MarvelAPIStudyProject
//
//  Created by Felipe Lima de Carvalho (P) on 14/12/21.
//

import UIKit
import CryptoKit

class APIService {
   
    private let privateKey = "1be72de4faa6afbd68558025cd7b1c8a3ed9ac91"
    private let publicKey = "2a039887bd1b3d7a8fb4cfd16cfe7c71"
    private let ts = String(Date().timeIntervalSince1970)
    public var characters = [Result]()
    
    func marvelApiCall(using closure: @escaping (() -> Void)) {
        let baseUrl = URL(string: "http://gateway.marvel.com/v1/public/characters?ts=\(ts)&apikey=\(publicKey)&hash=\(convertToMD5())&limit=100")!
        
        let task = URLSession.shared.dataTask(with: baseUrl) { (data, response, error) in
            if let error = error {
                print(error)
            }
            
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                return
//            }
            
            if let data = data {
                guard let returnAPI = try? JSONDecoder().decode(ReturnApi.self, from: data) else { return }
                self.characters = returnAPI.data.results
                closure()
            }
            
        }
        
        task.resume()
    }
    
    private func convertToMD5() -> String {
        let apiData = (ts + privateKey + publicKey).data(using: .utf8)
        let apiHash = Insecure.MD5.hash(data: apiData!)
        return apiHash.map { String(format: "%02hhx", $0) }.joined()
    }
}
    


