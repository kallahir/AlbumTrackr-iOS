//
//  FirstViewController.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 4/16/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import UIKit
import CoreData

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var loadMoreView: UIView!
    var feed: [Feed] = []
    var isLoading: Bool!
    
    var feedList:[[String]] = []
    var list:[[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorStyle = .None
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.allowsSelection = false
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FeedViewController.refresh(_:)), forControlEvents: .ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        let rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(self.searchArtist))
        rightButton.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = rightButton
        
        do {
            try self.fetchedResultsController.performFetch()
        } catch {}
        self.fetchedResultsController.delegate = self
        self.loadFeedData()
        self.isLoading = false
    }
    
//    override func viewWillAppear(animated: Bool) {
//        self.viewWillAppear(animated)
//        self.tableView.reloadData()
//    }
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: "Release")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "releaseDate", ascending: false)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.sharedContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }()

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("FeedCell") as! FeedCell
        
        let release = fetchedResultsController.objectAtIndexPath(indexPath) as! Release
        
        cell.feedImage.image = UIImage(named: release.imagePath!)
        cell.artistName.text = "ARTIST \(indexPath.row)"
        cell.releaseInfo.text = release.name
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "DD/MM/YYYY"
        cell.releaseDate.text = dateFormatter.stringFromDate(release.releaseDate)
        cell.releaseTypeImage.image = UIImage(named: release.primaryType!)
        cell.releaseType.text = NSLocalizedString(release.primaryType!, comment: "Release Type")
        
        return cell
    }
    
    func refresh(refreshControl: UIRefreshControl){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            NSThread.sleepForTimeInterval(0.5)
            
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.beginUpdates()
                self.updateFeedData()
                self.tableView.endUpdates()
                
                refreshControl.endRefreshing()
            }
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if (maxOffset - offset) <= 55 {
            self.loadMore()
        }
    }
    
    func loadMore(){
        if !self.isLoading {
            self.isLoading = true;
            self.loadMoreView.hidden = false
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                NSThread.sleepForTimeInterval(1.5)
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.beginUpdates()
                    self.loadMoreFeedData()
                    self.tableView.endUpdates()
                }
                
                self.isLoading = false
                self.loadMoreView.hidden = true
            })
        }
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Insert:
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            let cell = tableView.cellForRowAtIndexPath(indexPath!) as! FeedCell
            
            let release = fetchedResultsController.objectAtIndexPath(indexPath!) as! Release
            
            cell.feedImage.image = UIImage(named: release.imagePath!)
            cell.artistName.text = "ARTIST \(indexPath!.row)"
            cell.releaseInfo.text = release.name
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "dd/MM/YYYY"
            cell.releaseDate.text = dateFormatter.stringFromDate(release.releaseDate)
            cell.releaseTypeImage.image = UIImage(named: release.primaryType!)
            cell.releaseType.text = NSLocalizedString(release.primaryType!, comment: "Release Type")
        case .Move:
            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    func loadMoreFeedData() {
        self.addRelease(self.feedList[self.getRandomNumberBetween(0, To: self.feedList.count-1)])
        self.addRelease(self.feedList[self.getRandomNumberBetween(0, To: self.feedList.count-1)])
        self.addRelease(self.feedList[self.getRandomNumberBetween(0, To: self.feedList.count-1)])
    }
    
    func updateFeedData() {
        self.addRelease(self.feedList[self.getRandomNumberBetween(0, To: self.feedList.count-1)])
        self.addRelease(self.feedList[self.getRandomNumberBetween(0, To: self.feedList.count-1)])
    }
    
    func loadFeedData(){
        self.feedList.append(["David Bowie","Starman","david_bowie","09/02/1972","release_type_single"])
        self.feedList.append(["Green Day","American Idiot","green_day","20/09/2004","release_type_album"])
        self.feedList.append(["Nirvana","Nevermind","nirvana","20/09/2004","release_type_ep"])
        self.feedList.append(["Rolling Stones","Satisfaction","rolling_stones","20/09/2004","release_type_ep"])
        self.feedList.append(["Pink Floyd","Dark Side of the Moon","pink_floyd","20/09/2004","release_type_other"])
        
        for feed in feedList {
            self.addRelease(feed)
        }
        
        self.list.append(["David Bowie","Rock","Starman","david_bowie"])
        self.list.append(["Green Day","Punk Rock","American Idiot","green_day"])
        self.list.append(["Nirvana","Grungie","Nevermind","nirvana"])
        self.list.append(["Rolling Stones","Rock 'n Roll","Satisfaction","rolling_stones"])
        self.list.append(["Pink Floyd","Progressive Rock","Dark Side of The Moon","pink_floyd"])
    }
    
    func addRelease(values: [String]){
        let dictionary: [String : AnyObject] = [
            Release.Keys.name : values[1],
            Release.Keys.isAlbum : self.isAlbum(values[4]),
            Release.Keys.imagePath : values[2],
            Release.Keys.releaseGroupGid : "XYZ",
            Release.Keys.releaseGroupId : 123,
            Release.Keys.primaryType : values[4],
            Release.Keys.secondaryType : "SEC_TYPE",
            Release.Keys.releaseDate : NSDate(timeIntervalSince1970: self.randomTimeInterval())
        ]
        let _ = Release(dictionary: dictionary, context: sharedContext)
        
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    func isAlbum(release_type: String) -> Bool {
        if release_type == "release_type_album" {
            return true
        }
        
        return false
    }
    
    func randomTimeInterval() -> Double {
        return Double(arc4random())
    }
    
    func addArtist(values: [String]){
        let dictionary: [String : AnyObject] = [
            Artist.Keys.name : values[0],
            Artist.Keys.lastAlbum : values[2],
            Artist.Keys.imagePath : values[3] ?? ""
        ]
        let _ = Artist(dictionary: dictionary, context: sharedContext)
        
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    func getRandomNumberBetween (From: Int , To: Int) -> Int {
        return From + Int(arc4random_uniform(UInt32(To - From + 1)))
    }
    
    func searchArtist(){
        self.addArtist(self.list[self.getRandomNumberBetween(0, To: 4)])
//        self.performSegueWithIdentifier("SearchFromFeed", sender: self)
    }
    
}
