//
//  UserCell.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 5/8/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    
    override func layoutSubviews() {
        self.setupImage()
        self.setupImageEditAction()
        self.editButton.addTarget(self, action: #selector(self.editImage), forControlEvents: .TouchUpInside)
    }
    
    func setupImage(){
        self.userImage.layer.cornerRadius = self.userImage.frame.size.width/2
        self.userImage.clipsToBounds = true
        self.userImage.layer.borderWidth = 1.0
        self.userImage.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    func setupImageEditAction(){
        let editImageGesture = UITapGestureRecognizer(target: self, action: #selector(self.editImage))
        editImageGesture.numberOfTapsRequired = 1
        self.userImage.userInteractionEnabled = true
        self.userImage.addGestureRecognizer(editImageGesture)
    }
    
    func editImage(){
        print("EDIT IMAGE!")
    }
}
