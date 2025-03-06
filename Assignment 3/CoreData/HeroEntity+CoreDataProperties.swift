//
//  HeroEntity+CoreDataProperties.swift
//  Assignment 3
//
//  Created by yunus on 06.03.2025.
//
//

import Foundation
import CoreData


extension HeroEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HeroEntity> {
        return NSFetchRequest<HeroEntity>(entityName: "HeroEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var gender: String?
    @NSManaged public var race: String?
    @NSManaged public var height: String?
    @NSManaged public var weight: String?
    @NSManaged public var intelligence: Int16
    @NSManaged public var strength: Int16
    @NSManaged public var speed: Int16
    @NSManaged public var durability: Int16
    @NSManaged public var power: Int16
    @NSManaged public var combat: Int16
    @NSManaged public var imageURL: String

}

extension HeroEntity : Identifiable {

}
