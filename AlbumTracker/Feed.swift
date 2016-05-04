//
//  Feed.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 5/2/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import Foundation

class Feed {
    var releaseArtist: String?
    var releaseInfo: String?
    var releaseImage: String? // CHANGE TO IMAGE PATH
    var releaseDate: String? // CHANGE TO DATE
    var releaseType: String?
    
    init(releaseArtist: String, releaseInfo: String, releaseImage: String, releaseDate: String, releaseType: String){
        self.releaseArtist  = releaseArtist
        self.releaseInfo    = releaseInfo
        self.releaseImage   = releaseImage
        self.releaseDate    = releaseDate
        self.releaseType    = releaseType
    }
    
}