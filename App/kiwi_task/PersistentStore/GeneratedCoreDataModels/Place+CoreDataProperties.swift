//
//  Place+CoreDataProperties.swift
//  kiwi_task
//
//  Created by Michal Cickan on 21/09/2023.
//
//

import Foundation
import CoreData


extension ManagedPlace {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedPlace> {
        return NSFetchRequest<ManagedPlace>(entityName: "Place")
    }

    @NSManaged public var legacyId: String?
    @NSManaged public var id: String?
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var name: String

}

extension ManagedPlace : Identifiable {

}
