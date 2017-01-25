//
//  WebserviceManager .swift
//  FlickedMe
//
//  Created by Mayu on 22/1/17.
//  Copyright © 2017 Mayu. All rights reserved.
//

import Foundation


struct WSConfig {
    static var manager = WSConfig()
    
     let public_photo_url :String = "https://api.flickr.com/services/feeds/photos_public.gne?api_key=e9a967ec3500e36868d562cbb0bc0565&format=json&nojsoncallback=1&lang=en-us"
    
}


class WebserviceManager {
    
    func getPublicPhotos(succuess :   @escaping ([[String : AnyObject]]) -> () , failureDescription : @escaping (Error) -> () ){
        
        let request = URLRequest(url: URL(string: WSConfig.manager.public_photo_url)!)
        let session = URLSession.shared
        session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil {
                failureDescription(error!)
                return;
            }
            guard let data = data else { print("No data received"); return }
            do{
                var jsonResult = try JSONSerialization.jsonObject(with: data,options:JSONSerialization.ReadingOptions.mutableContainers) as! [String : AnyObject]
                 succuess (jsonResult["items"] as! [[String : AnyObject]])
            }catch{
                print("parsing issue")
                
            }
            }.resume()
    }
    

    

    
}
