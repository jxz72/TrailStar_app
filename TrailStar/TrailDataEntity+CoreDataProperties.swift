//
//  TrailDataEntity+CoreDataProperties.swift
//  TrailStar
//
//  Created by Jeffrey Zhou on 4/17/22.
//
//

import Foundation
import CoreData


extension TrailDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrailDataEntity> {
        return NSFetchRequest<TrailDataEntity>(entityName: "TrailDataEntity")
    }

    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var desc: String?
    @NSManaged public var directionsBlurb: String?
    @NSManaged public var length: Float
    @NSManaged public var name: String?
    @NSManaged public var state: String?
    @NSManaged public var lat: Double
    @NSManaged public var lon: Double

}

extension TrailDataEntity : Identifiable {

}
