//
//  FirstViewController.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 4/16/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var feed: [Feed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .None
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.allowsSelection = false
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FeedViewController.refresh(_:)), forControlEvents: .ValueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("last_update", comment: "Last Update"))
        self.tableView.addSubview(refreshControl)
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(self.searchArtist))
        rightButton.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = rightButton
        
        self.loadFeedData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("FeedCell") as! FeedCell
        
        cell.feedImage.image = UIImage(named: feed[indexPath.row].releaseImage!)
        cell.artistName.text = feed[indexPath.row].releaseArtist
        cell.releaseInfo.text = feed[indexPath.row].releaseInfo
        cell.releaseDate.text = feed[indexPath.row].releaseDate
        cell.releaseTypeImage.image = UIImage(named: feed[indexPath.row].releaseType!)
        cell.releaseType.text = NSLocalizedString(feed[indexPath.row].releaseType!, comment: "Release Type")
        
        return cell
    }
    
    func refresh(refreshControl: UIRefreshControl){
        dispatch_async(dispatch_get_main_queue(), {
            let indexesPath = self.updateFeedData()
            
            NSThread.sleepForTimeInterval(0.5)
            
            self.tableView.beginUpdates()
            self.tableView.insertRowsAtIndexPaths(indexesPath, withRowAnimation: UITableViewRowAnimation.Fade)
            self.tableView.endUpdates()
            
            refreshControl.endRefreshing()
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    func updateFeedData() -> [NSIndexPath] {
        var indexesPath = [NSIndexPath]()
        
        self.feed.insert(Feed(releaseArtist: "Rolling Stones", releaseInfo: "Satisfaction - The newest addition to your news feed!", releaseImage: "rolling_stones", releaseDate: "1966", releaseType: "release_type_other"), atIndex: 0)
        indexesPath.append(NSIndexPath(forRow: 0, inSection: 0))
        self.feed.insert(Feed(releaseArtist: "Rolling Stones", releaseInfo: "Satisfaction - The newest addition to your news feed!", releaseImage: "rolling_stones", releaseDate: "1965", releaseType: "release_type_other"), atIndex: 0)
        indexesPath.append(NSIndexPath(forRow: 1, inSection: 0))
        
        return indexesPath
    }
    
    func loadFeedData(){
        self.feed.append(Feed(releaseArtist: "David Bowie", releaseInfo: "Starman", releaseImage: "david_bowie", releaseDate: "09/02/1972", releaseType: "release_type_single"))
        self.feed.append(Feed(releaseArtist: "Green Day", releaseInfo: "American Idiot", releaseImage: "green_day", releaseDate: "20/09/2004", releaseType: "release_type_album"))
        self.feed.append(Feed(releaseArtist: "Nirvana", releaseInfo: "Nevermind", releaseImage: "nirvana", releaseDate: "24/09/1991", releaseType: "release_type_ep"))
        self.feed.append(Feed(releaseArtist: "Pink Floyd", releaseInfo: "Dark Side of the Moon", releaseImage: "pink_floyd", releaseDate: "01/03/1973", releaseType: "release_type_ep"))
        self.feed.append(Feed(releaseArtist: "Rolling Stones", releaseInfo: "Satisfaction", releaseImage: "rolling_stones", releaseDate: "1965", releaseType: "release_type_other"))
    }
    
    func searchArtist(){
        self.performSegueWithIdentifier("SearchFromFeed", sender: self)
    }
    
}

