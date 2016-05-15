//
//  Release.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 5/15/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import CoreData

class Release: NSManagedObject {
    @NSManaged var releaseGroupId: NSNumber
    @NSManaged var releaseGroupGid: String?
    @NSManaged var releaseDate: NSDate
    @NSManaged var name: String?
    @NSManaged var imagePath: String?
    @NSManaged var primaryType: String?
    @NSManaged var secondaryType: String?
    @NSManaged var isAlbum: Bool
    
    struct Keys {
        static let releaseGroupId = "releaseGroupId"
        static let releaseGroupGid = "releaseGroupGid"
        static let releaseDate = "releaseDate"
        static let name = "name"
        static let imagePath = "imagePath"
        static let primaryType = "primaryType"
        static let secondaryType = "secondaryType"
        static let isAlbum = "isAlbum"
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        let entity =  NSEntityDescription.entityForName("Release", inManagedObjectContext: context)!
        
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
        releaseGroupId = dictionary[Keys.releaseGroupId] as! NSNumber
        releaseGroupGid = dictionary[Keys.releaseGroupGid] as? String
        releaseDate = dictionary[Keys.releaseDate] as! NSDate
        name = dictionary[Keys.name] as? String
        imagePath = dictionary[Keys.imagePath] as? String
        primaryType = dictionary[Keys.primaryType] as? String
        secondaryType = dictionary[Keys.secondaryType] as? String
        isAlbum = dictionary[Keys.isAlbum] as! Bool
    }
}