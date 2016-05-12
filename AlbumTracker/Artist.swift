//
//  Artist.swift
//  AlbumTracker
//
//  Created by Itallo Rossi Lucas on 5/2/16.
//  Copyright © 2016 AlbumTrackr. All rights reserved.
//

import CoreData

class Artist: NSManagedObject {
    @NSManaged var id: NSNumber
    @NSManaged var name: String?
    @NSManaged var style: String?
    @NSManaged var lastAlbum: String?
    @NSManaged var imagePath: String?
//    var artistAlbums: [Album] = []
    
    struct Keys {
        static let id = "id"
        static let name = "name"
        static let style = "style"
        static let lastAlbum = "lastAlbum"
        static let imagePath = "imagePath"
        static let albums = "albums"
    }
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        let entity =  NSEntityDescription.entityForName("Artist", inManagedObjectContext: context)!
        
        super.init(entity: entity,insertIntoManagedObjectContext: context)
        
//        id = dictionary[Keys.id] as! Int
        name = dictionary[Keys.name] as? String
//        style = dictionary[Keys.style] as? String
        lastAlbum = dictionary[Keys.lastAlbum] as? String
        imagePath = dictionary[Keys.imagePath] as? String
    }
}