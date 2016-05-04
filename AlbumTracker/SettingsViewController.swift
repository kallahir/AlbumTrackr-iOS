//
//  SettingsViewController.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 4/16/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var settingsList = [["account","notification"],["help","about"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.scrollEnabled = false
        
        dispatch_async(dispatch_get_main_queue(), {
            var frame: CGRect
            frame = self.tableView.frame
            frame.size.height = self.tableView.contentSize.height
            self.tableView.frame = frame
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SettingsCell") as UITableViewCell!
        
        cell.textLabel!.text = NSLocalizedString(self.settingsList[indexPath.section][indexPath.row], comment: "Setting Property")
        cell.imageView?.image = UIImage(named: self.settingsList[indexPath.section][indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return 2
        }
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(indexPath.section) - \(indexPath.row) - \(self.settingsList[indexPath.section][indexPath.row])")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.settingsList.count
    }

}

