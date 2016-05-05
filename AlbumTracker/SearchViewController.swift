//
//  SearchViewController.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 5/5/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var artists:[Artist] = []
    var filteredArtists = [Artist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.searchBar.placeholder = NSLocalizedString("search_artist", comment: "Search Artist")
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        self.loadData()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchCell")! as UITableViewCell
        
        if(filteredArtists.count > 0){
            cell.textLabel?.text = filteredArtists[indexPath.row].artistName
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArtists.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredArtists = artists.filter({ artist in
            return (artist.artistName?.lowercaseString.containsString(searchText.lowercaseString))!
        })
        self.tableView.reloadData()
    }
    
    func loadData(){
        self.artists.append(Artist(artistName: "David Bowie", artistStyle: "Rock", artistNewestAlbum: "Starman", artistImage: "david_bowie"))
        self.artists.append(Artist(artistName: "Green Day", artistStyle: "Punk Rock", artistNewestAlbum: "American Idiot", artistImage: "green_day"))
        self.artists.append(Artist(artistName: "Nirvana", artistStyle: "Grungie", artistNewestAlbum: "Nevermind", artistImage: "nirvana"))
        self.artists.append(Artist(artistName: "Pink Floyd", artistStyle: "Progressive Rock", artistNewestAlbum: "Dark Side of The Moon", artistImage: "pink_floyd"))
        self.artists.append(Artist(artistName: "Rolling Stones", artistStyle: "Rock 'n Roll", artistNewestAlbum: "Satisfaction", artistImage: "rolling_stones"))
    }
}
