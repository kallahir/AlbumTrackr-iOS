//
//  SecondViewController.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 4/16/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var list:[[String]] = []
    var artists: [Artist] = []
    var selectedArtist: NSIndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImage.image = UIImage(named: "profile_pic")
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.borderWidth = 2.0
        self.profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.nickname.text = "Itallo Rossi \(self.flag("BR"))"
        
        self.tableView.bounces = false
        self.tableView.showsVerticalScrollIndicator = false

        let rightButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(self.searchArtist))
        rightButton.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = rightButton
        
        do {
            try fetchedResultsController.performFetch()
        } catch {}
        
        fetchedResultsController.delegate = self
        self.loadArtistsData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let fetchRequest = NSFetchRequest(entityName: "Artist")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.sharedContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultsController
    }()
    
    func flag(country:String) -> String {
        let base:UInt32 = 127397
        var s = ""
        
        for v in country.unicodeScalars{
            s.append(UnicodeScalar(base+v.value))
        }
        
        return s
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArtistCell") as! ArtistCell
        
        let artist = fetchedResultsController.objectAtIndexPath(indexPath) as! Artist
        cell.artistName.text = artist.name
        cell.artistImage.image = UIImage(named: artist.imagePath!)
        cell.artistNewestAlbum.text = "\(NSLocalizedString("newest_album", comment: "Newest Album")) \(artist.lastAlbum!)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return NSLocalizedString("artists_followed", comment: "Artitsts Followed")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let unfollow = UITableViewRowAction(style: .Normal, title: NSLocalizedString("unfollow", comment: "Unfollow"), handler: {(UITableViewRowAction, indexPath) in
            let artist = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Artist
            self.sharedContext.deleteObject(artist)
            CoreDataStackManager.sharedInstance().saveContext()
        })
        
        unfollow.backgroundColor = UIColor.redColor()
        
        return [unfollow]
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
//        case .Update:
//            let cell = tableView.cellForRowAtIndexPath(indexPath!) as! ArtistCell
//            let artist = controller.objectAtIndexPath(indexPath!) as! Artist
//            cell.artistName.text = artist.name
//            cell.artistImage.image = UIImage(named: artist.imagePath!)
//            cell.artistNewestAlbum.text = "\(NSLocalizedString("newest_album", comment: "Newest Album")) \(artist.lastAlbum!)"
//        case .Move:
//            self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
//            self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        default:
            print("NADA!")
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.selectedArtist = indexPath
        self.performSegueWithIdentifier("ShowArtist", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowArtist" {
            let artistVC = segue.destinationViewController as! ArtistViewController
            artistVC.artist = self.fetchedResultsController.objectAtIndexPath(self.selectedArtist) as! Artist
        }
    }
    
    func loadArtistsData(){
        self.list.append(["David Bowie","Rock","Starman","david_bowie"])
        self.list.append(["Green Day","Punk Rock","American Idiot","green_day"])
        self.list.append(["Nirvana","Grungie","Nevermind","nirvana"])
        self.list.append(["Rolling Stones","Rock 'n Roll","Satisfaction","rolling_stones"])
        self.list.append(["Pink Floyd","Progressive Rock","Dark Side of The Moon","pink_floyd"])
//        self.loadAlbumData()
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
    
//    func loadAlbumData(){
//        for artist in artists {
//            for j in 1...5 {
//                artist.artistAlbums.append(Album(albumImage: artist.artistImage!, albumName: artist.artistNewestAlbum!, albumNumOfTracks: 10+j))
//            }
//        }
//    }
    
    func getRandomNumberBetween (From: Int , To: Int) -> Int {
        return From + Int(arc4random_uniform(UInt32(To - From + 1)))
    }
    
    func searchArtist(){
        self.addArtist(self.list[self.getRandomNumberBetween(0, To: 4)])
//        self.performSegueWithIdentifier("SearchFromProfile", sender: self)
    }
    
}

