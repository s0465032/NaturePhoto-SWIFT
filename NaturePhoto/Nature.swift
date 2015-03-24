//
//  Nature.swift
//  NaturePhoto
//
//  Created by Charles Konkol on 3/23/15.
//  Copyright (c) 2015 Rock Valley College. All rights reserved.
//

import Foundation
import CoreData

class Nature: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var location: String
    @NSManaged var photos: NSData
    @NSManaged var desc: String
    @NSManaged var fav: Boolean

}
