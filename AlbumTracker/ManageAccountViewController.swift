//
//  ManageAccoutnViewController.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 5/8/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import UIKit

class ManageAccoutnViewController: UITableViewController {
    
    var notificationType = ["notification_album","notification_ep","notification_single","notification_other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.bounces = false
        self.tableView.allowsSelection = false
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("NotificationCell") as! NotificationCell
            
            cell.notificationText.text = NSLocalizedString(self.notificationType[indexPath.row], comment: "Notification Type")
            cell.notificationDetail.text = NSLocalizedString(self.notificationType[indexPath.row]+"_details", comment: "Notification Type Details")
            cell.notificationSelection.setOn(true, animated: true)
            
            return cell
        }
        
        if indexPath.section == 0 && indexPath.row == 0 {
            let cell = self.tableView.dequeueReusableCellWithIdentifier("UserCell") as! UserCell
            
            cell.userImage.image = UIImage(named: "profile_pic")
            cell.userName.text = "Itallo Rossi"
            
            return cell
        }
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier("EmailCell") as! EmailCell
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return self.notificationType.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 120
        }
        
        return 55
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Manage Account"
        }
        return "Notifications"
    }

}
