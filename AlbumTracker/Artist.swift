//
//  Artist.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 5/2/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import Foundation

class Artist {
    var artistName: String?
    var artistStyle: String?
    var artistNewestAlbum: String?
    var artistImage: String? // CHANGE TO IMAGE PATH
    var artistAlbums: [Album] = []
    
    init(artistName: String, artistStyle: String, artistNewestAlbum: String, artistImage: String) {
        self.artistName         = artistName
        self.artistStyle        = artistStyle
        self.artistNewestAlbum  = artistNewestAlbum
        self.artistImage        = artistImage
    }
}