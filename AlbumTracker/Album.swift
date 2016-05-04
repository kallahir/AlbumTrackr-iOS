//
//  Album.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 5/2/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import Foundation

class Album {
    var albumImage: String? // CHANGE TO IMAGE PATH
    var albumName: String?
    var albumNumOfTracks: Int
    
    init(albumImage: String, albumName: String, albumNumOfTracks: Int){
        self.albumImage         = albumImage
        self.albumName          = albumName
        self.albumNumOfTracks   = albumNumOfTracks
    }
}