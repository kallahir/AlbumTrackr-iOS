//
//  ArtistViewController.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 5/3/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import UIKit

class ArtistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    
    let tableHeaderHeight: CGFloat = 300.0
    var headerView: UIView!
    var albums: [Album] = []
    var artist: Artist!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.artistName.text = self.artist.name
        self.artistName.backgroundColor = UIColor(red: 20/255, green: 87/255, blue: 127/255, alpha: 0.8)
        self.artistImage.image = UIImage(named: self.artist.imagePath!)
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.tableView.allowsSelection = false
        self.tableView.showsVerticalScrollIndicator = false
        
        self.headerView = self.tableView.tableHeaderView
        self.tableView.tableHeaderView = nil
        self.tableView.addSubview(self.headerView)
        
        self.tableView.contentInset = UIEdgeInsets(top: self.tableHeaderHeight, left: 0, bottom: 0, right: 0)
        self.tableView.contentOffset = CGPoint(x: self.tableHeaderHeight, y: -self.tableHeaderHeight)
        
        self.updateHeaderView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("AlbumCell") as! AlbumCell
        
        cell.albumName.text = albums[indexPath.row].albumName
        cell.albumDetails.text =  "\(NSLocalizedString("Artist.num_of_tracks", comment: "Number of Tracks")) \(albums[indexPath.row].albumNumOfTracks)"
        cell.albumImage.image = UIImage(named: albums[indexPath.row].albumImage!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func updateHeaderView(){
        var headerRect = CGRect(x: 0, y: -self.tableHeaderHeight, width: self.tableView.bounds.width, height: self.tableHeaderHeight)
        
        if self.tableView.contentOffset.y < -self.tableHeaderHeight {
            headerRect.origin.y = self.tableView.contentOffset.y
            headerRect.size.height = -self.tableView.contentOffset.y
        }
        
        self.headerView.frame = headerRect
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
}

class ArtistNameLabel: UILabel {
    override func drawTextInRect(rect: CGRect) {
        let insets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
}
