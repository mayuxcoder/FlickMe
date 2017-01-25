//
//  FlickerTableViewDelegate.swift
//  FlickedMe
//
//  Created by Mayu on 22/1/17.
//  Copyright © 2017 Mayu. All rights reserved.
//

import Foundation
import UIKit
class FlickerTableViewDelegate : NSObject , UITableViewDelegate , UITableViewDataSource{
    
    var imageDataSet =  [[String:AnyObject]]()
    var spinner : UIActivityIndicatorView!
    var pageNo = 0
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageDataSet.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "flickerCellidentifier", for: indexPath) as! FlickerImageCell
        
        cell.setImageData( data: imageDataSet[indexPath.row], row: indexPath.row)
        return cell
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset:CGPoint = scrollView.contentOffset
        let bounds:CGRect = scrollView.bounds
        let size:CGSize = scrollView.contentSize
        let inset:UIEdgeInsets = scrollView.contentInset
        let y = offset.y + bounds.size.height - inset.bottom
        let h = size.height
        if y > h{
            NotificationCenter.default.post(NSNotification(name: NSNotification.Name(rawValue: "loadMore"), object: nil) as Notification)
        }

        }
    
    
   
}
