//
//  FlickerViewController.swift
//  FlickedMe
//
//  Created by Mayu on 22/1/17.
//  Copyright © 2017 Mayu. All rights reserved.
//

import Foundation
import UIKit

class FlickerViewController : UIViewController{
    
    @IBOutlet weak var flickerTableView: UITableView!
    var tableViewDataSource  =  FlickerTableViewDelegate()
    var spinner : UIActivityIndicatorView!
    var wsManager : WebserviceManager!

    override func viewDidLoad() {

        self.configTv()
        NotificationCenter.default.addObserver(self, selector: #selector(FlickerViewController.loadMore), name: NSNotification.Name(rawValue: "loadMore"), object: nil)

        self.callWS()
        
    }
    func callWS(){
        self.wsManager = WebserviceManager()
        self.wsManager.getPublicPhotos(succuess: { flickerImageDataSet in
            self.tableViewDataSource.imageDataSet += flickerImageDataSet
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.flickerTableView.reloadData()
            }
            
        }) { error in
            print(error.localizedDescription)
        }

    }
    func loadMore(){
        self.spinner.startAnimating()
        callWS()
    }
    
    func configTv(){
        self.flickerTableView.delegate = tableViewDataSource
        self.flickerTableView.dataSource = tableViewDataSource
        self.flickerTableView.rowHeight = 300
        self.flickerTableView.isPagingEnabled = true
        
        
        let bottomView:UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        bottomView.backgroundColor = UIColor.white
        spinner = UIActivityIndicatorView.init(frame: bottomView.frame)
        spinner.activityIndicatorViewStyle = .gray
        bottomView.addSubview(spinner)
        flickerTableView.tableFooterView = spinner
    }
    
}
