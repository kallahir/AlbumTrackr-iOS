//
//  ArtistCell.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 4/18/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import UIKit

class ArtistCell: UITableViewCell {
    
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var artistStyle: UILabel!
    @IBOutlet weak var artistNewestAlbum: UILabel!
    
    override func layoutSubviews() {
        self.setupImage()
    }
    
    func setupImage(){
        self.artistImage.layer.cornerRadius = 2.0;
        self.artistImage.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.artistImage.layer.borderWidth = 1.0
        self.artistImage.clipsToBounds = true;
    }
    
}
