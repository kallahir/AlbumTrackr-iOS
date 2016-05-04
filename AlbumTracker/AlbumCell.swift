//
//  AlbumCell.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 5/3/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var albumDetails: UILabel!
    
    override func layoutSubviews() {
        self.setupImage()
    }
    
    func setupImage(){
        self.albumImage.layer.cornerRadius = 2.0;
        self.albumImage.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.albumImage.layer.borderWidth = 1.0
        self.albumImage.clipsToBounds = true;
    }
    
}