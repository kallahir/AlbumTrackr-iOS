//
//  FeedCell.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 4/17/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var feedView: UIView!
    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var releaseInfo: UILabel!
    @IBOutlet weak var feedHeaderView: UIView!
    @IBOutlet weak var releaseTypeImage: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var releaseType: UILabel!
    
    override func layoutSubviews() {
        self.setupFeedArea()
        self.setupImage()
        self.setupFeedHeader()
    }
    
    func setupFeedArea(){
        self.feedView.alpha = 1.0
        self.feedView.layer.masksToBounds = false
        self.feedView.layer.cornerRadius = 3.0
        self.feedView.layer.shadowOffset = CGSizeMake(-0.1, 0.1)
        self.feedView.layer.shadowRadius = 0.5
        self.feedView.layer.borderWidth = 0.5
        self.feedView.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    
    func setupImage(){
        self.feedImage.layer.cornerRadius = 2.0;
        self.feedImage.clipsToBounds = true;
    }
    
    func setupFeedHeader(){
        self.feedHeaderView.layer.masksToBounds = false
        self.feedHeaderView.layer.borderWidth = 0.5
        self.feedHeaderView.layer.cornerRadius = 3.0
        self.feedHeaderView.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    
}
