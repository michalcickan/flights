import Foundation
import CoreData
import UmbrellaAPI

final class CoreDataStore: PersistenStorage {
    let container = NSPersistentContainer(name: "Flights")
    
    override var filter: PersistentFilter? {
        get {
            let context = container.viewContext
            do {
                return try context.fetch(ManagedFilter.fetchRequest()).first?.persistentFilter
            } catch {
                print("Error fetching filter: \(error.localizedDescription)")
                return nil
            }
        }
        set(newFilter) {
            let context = container.viewContext
            guard let newFilter else {
                return
            }
            defer {
                do {
                    try context.save()
                } catch {
                    print("Error saving filter: \(error.localizedDescription)")
                }
            }
            guard let filter = try? context.fetch(ManagedFilter.fetchRequest()).first else {
                newFilter.saveManagedObject(inContext: context)
                return
            }
            filter.update(with: newFilter)
        }
    }
    
    override var places: [PersistentPlace]? {
        get {
            let context = container.viewContext
            do {
                return try context.fetch(ManagedPlace.fetchRequest()).map { $0.persistentPlace }
            } catch {
                print("Error fetching places: \(error.localizedDescription)")
                return nil
            }
        }
        set(newPlaces) {
            let context = container.viewContext
            if let newPlaces = newPlaces {
                newPlaces
                    .forEach { $0.saveManagedObject(inContext: context) }
                do {
                    try context.save()
                } catch {
                    print("Error saving places: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    override init() {
        container.loadPersistentStores { persistentStoreDescription, error in
            if let error {
                print("Core data store initialization has failed: \(error.localizedDescription)")
            }
        }
    }
}

fileprivate extension ManagedFilter {
    var persistentFilter: PersistentFilter {
        PersistentFilter(
            sources: sources?.stringArray,
            destinations: destinations?.stringArray,
            cabinClassType: CabinClassType(rawValue: cabinClassType ?? ""),
            sortBy: .init(rawValue: sortBy ?? ""),
            numberOfAdults: Int(numberOfAdults),
            adultsHoldBags: adultsHoldBags?.intArray
        )
    }
    
    func update(with filter: PersistentFilter) {
        sources = filter.sources?.object
        destinations = filter.destinations?.object
        cabinClassType = filter.cabinClassType?.rawValue
        sortBy = filter.sortBy?.rawValue
        numberOfAdults = Int16(filter.numberOfAdults ?? 0)
        adultsHoldBags = filter.adultsHoldBags?.object
        
    }
}

fileprivate extension ManagedPlace {
    var persistentPlace: PersistentPlace {
        PersistentPlace(
            imageUrl: imageUrl,
            id: id!,
            lat: lat,
            lng: lng,
            name: name
        )
    }
}

fileprivate extension PersistentPlace {
    func saveManagedObject(inContext context: NSManagedObjectContext) {
        let managedPlace = ManagedPlace(context: context)
        managedPlace.imageUrl = imageUrl
        managedPlace.id = id
        managedPlace.lat = lat
        managedPlace.lng = lng
        managedPlace.name = name
    }
}

fileprivate extension PersistentFilter {
    func saveManagedObject(inContext context: NSManagedObjectContext) {
        let managedFilter = ManagedFilter(context: context)
        managedFilter.sources = sources?.object
        managedFilter.destinations = destinations?.object
        managedFilter.cabinClassType = cabinClassType?.rawValue
        managedFilter.sortBy = sortBy?.rawValue
        managedFilter.numberOfAdults = numberOfAdults?.number ?? 1
        managedFilter.adultsHoldBags = adultsHoldBags?.object
    }
}

fileprivate extension Int {
    var number: Int16 {
        Int16(self)
    }
}

fileprivate extension Array<Int> {
    var object: NSObject {
        map { NSNumber(value: $0) } as NSObject
    }
}

fileprivate extension Array<String> {
    var object: NSObject {
        map { NSString(string: $0) } as NSObject
    }
}

fileprivate extension NSObject {
    var stringArray: [String]? {
        (self as? [NSString])?
            .map { String(describing: $0) }
    }
    
    var intArray: [Int]? {
        (self as? [NSNumber])?
            .map { $0.intValue }
    }
}
