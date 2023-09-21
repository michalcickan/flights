//
//  Filter+CoreDataProperties.swift
//  kiwi_task
//
//  Created by Michal Cickan on 21/09/2023.
//
//

import Foundation
import CoreData


extension ManagedFilter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedFilter> {
        return NSFetchRequest<ManagedFilter>(entityName: "Filter")
    }

    @NSManaged public var sources: NSObject?
    @NSManaged public var destinations: NSObject?
    @NSManaged public var cabinClassType: String?
    @NSManaged public var sortBy: String?
    @NSManaged public var numberOfAdults: Int16
    @NSManaged public var adultsHoldBags: NSObject?

}

extension ManagedFilter : Identifiable {

}
