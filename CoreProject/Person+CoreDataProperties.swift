//
//  Person+CoreDataProperties.swift
//  CoreProject
//
//  Created by IPS-161 on 12/01/23.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var age: String?
    @NSManaged public var isActive: Bool

}

extension Person : Identifiable {

}
