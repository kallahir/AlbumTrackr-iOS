//
//  SecondViewController.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 4/16/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var artists: [Artist] = []
    var selectedArtist: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadArtistsData()
        
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
    }
    
    func flag(country:String) -> String {
        let base:UInt32 = 127397
        var s = ""
        
        for v in country.unicodeScalars{
            s.append(UnicodeScalar(base+v.value))
        }
        
        return s
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArtistCell") as! ArtistCell
        
        cell.artistName.text = artists[indexPath.row].artistName
        cell.artistImage.image = UIImage(named: artists[indexPath.row].artistImage!)
        cell.artistNewestAlbum.text = "\(NSLocalizedString("newest_album", comment: "Newest Album")) \(artists[indexPath.row].artistNewestAlbum!)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artists.count
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
            self.artists.removeAtIndex(indexPath.row)
            var indexesPath = [NSIndexPath]()
            indexesPath.append(NSIndexPath(forRow: indexPath.row, inSection: 0))
            self.tableView.deleteRowsAtIndexPaths(indexesPath, withRowAnimation: .Right)
            self.tableView.setEditing(false, animated: true)
        })
        
        unfollow.backgroundColor = UIColor.redColor()
        
        return [unfollow]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.selectedArtist = indexPath.row
        self.performSegueWithIdentifier("ShowArtist", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowArtist" {
            let artistVC = segue.destinationViewController as! ArtistViewController
            artistVC.albums = artists[self.selectedArtist].artistAlbums
            artistVC.artistNameText = artists[self.selectedArtist].artistName
            artistVC.artistImagePath = artists[self.selectedArtist].artistImage
        }
    }
    
    func loadArtistsData(){
        self.artists.append(Artist(artistName: "David Bowie", artistStyle: "Rock", artistNewestAlbum: "Starman", artistImage: "david_bowie"))
        self.artists.append(Artist(artistName: "Green Day", artistStyle: "Punk Rock", artistNewestAlbum: "American Idiot", artistImage: "green_day"))
        self.artists.append(Artist(artistName: "Nirvana", artistStyle: "Grungie", artistNewestAlbum: "Nevermind", artistImage: "nirvana"))
        self.artists.append(Artist(artistName: "Pink Floyd", artistStyle: "Progressive Rock", artistNewestAlbum: "Dark Side of The Moon", artistImage: "pink_floyd"))
        self.artists.append(Artist(artistName: "Rolling Stones", artistStyle: "Rock 'n Roll", artistNewestAlbum: "Satisfaction", artistImage: "rolling_stones"))
        self.artists.append(Artist(artistName: "David Bowie", artistStyle: "Rock", artistNewestAlbum: "Starman", artistImage: "david_bowie"))
        self.artists.append(Artist(artistName: "Green Day", artistStyle: "Punk Rock", artistNewestAlbum: "American Idiot", artistImage: "green_day"))
        self.artists.append(Artist(artistName: "Nirvana", artistStyle: "Grungie", artistNewestAlbum: "Nevermind", artistImage: "nirvana"))
        self.artists.append(Artist(artistName: "Pink Floyd", artistStyle: "Progressive Rock", artistNewestAlbum: "Dark Side of The Moon", artistImage: "pink_floyd"))
        self.artists.append(Artist(artistName: "Rolling Stones", artistStyle: "Rock 'n Roll", artistNewestAlbum: "Satisfaction", artistImage: "rolling_stones"))
        
        self.loadAlbumData()
    }
    
    func loadAlbumData(){
        for artist in artists {
            for j in 1...5 {
                artist.artistAlbums.append(Album(albumImage: artist.artistImage!, albumName: artist.artistNewestAlbum!, albumNumOfTracks: 10+j))
            }
        }
    }
    
    func searchArtist(){
        self.performSegueWithIdentifier("SearchFromProfile", sender: self)
    }
    
}

