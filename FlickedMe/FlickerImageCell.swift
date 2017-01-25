//
//  FlickerImageCell.swift
//  FlickedMe
//
//  Created by Mayu on 22/1/17.
//  Copyright © 2017 Mayu. All rights reserved.
//

import Foundation
import UIKit
class FlickerImageCell : UITableViewCell{
    
   
    var imageCache = NSCache<AnyObject, AnyObject>()

    
    @IBOutlet weak var publicImage: UIImageView!
 
  
    
    func setImageData(data: [String:AnyObject] , row : Int){
        guard let imageData = data["media"] else{print("image is not available") ; return }
        guard let imageUrl = imageData["m"] else{print("image is not available") ; return }
        let url = URL(string: imageUrl as! String)
        
        if (self.imageCache.object(forKey: row as AnyObject) != nil){
            publicImage.image = self.imageCache.object(forKey: row as AnyObject) as? UIImage
        }
        else{
            let session = URLSession.shared
            session.dataTask(with: url!, completionHandler: { (data, response, error) in
                if error != nil {print("there is an error in downloading")}
                guard let data = data else { return }
                
                self.imageCache.setObject(UIImage(data: data)!, forKey:row as AnyObject)
                DispatchQueue.main.async {
                  self.publicImage.image = UIImage(data: data)
                }
            }).resume()
        }
        
    }
    
   
}
