//
//  APIManger.swift
//  CollectionViewExample
//
//  Created by IMCS2 on 1/10/20.
//  Copyright © 2020 IMCS2. All rights reserved.
//

import Foundation


class APICall {
    
    func APIrequest(completionHandler: @escaping (Welcome) -> ()) {
        
        let urlString = "https://rss.itunes.apple.com/api/v1/in/itunes-music/hot-tracks/all/25/non-explicit.json"
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) {(data,response,error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            do {
                
                let retrievedData = try JSONDecoder().decode(Welcome.self, from: data!)
                
                completionHandler(retrievedData)
            }
                
            catch _ {
                print("Unable to parse data")
            }
            
            
            }.resume()
    }
    
    
}
