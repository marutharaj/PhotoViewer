//
//  ServiceManager.swift
//  PhotoViewer
//
//  Created by mac on 11/26/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

class ServiceManager {
    
    static let shared = ServiceManager()
    private init() {}
    
    func getPhotos(success: @escaping (_ photos: [Photo])->()?,
                   failure: @escaping (_ error: Error)->()?) {
        
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        
        guard let url = URL(string: urlString) else { return }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if let data = data {
                do {
                    let photos = try JSONDecoder().decode([Photo].self, from: data)
                    success(photos)
                }
                catch {
                    failure(error)
                }
            }
            
        }.resume()
    }
}
