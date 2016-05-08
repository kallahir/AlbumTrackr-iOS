//
//  EmailCell.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 5/8/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import UIKit

class EmailCell: UITableViewCell {
    
    @IBOutlet weak var emailSyncButton: UIButton!
    
    override func layoutSubviews() {
        self.emailSyncButton.tintColor = UIColor.redColor()
        self.emailSyncButton.setTitle("Sync account with email", forState: .Normal)
        
//        self.emailSyncButton.tintColor = UIColor.blackColor()
//        self.emailSyncButton.setTitle("Account synced with email", forState: .Normal)
        
        self.emailSyncButton.addTarget(self, action: #selector(self.syncEmail), forControlEvents: .TouchUpInside)
    }
    
    func syncEmail(){
        print("SYNC EMAIL")
    }
    
}
