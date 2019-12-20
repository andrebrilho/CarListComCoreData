//
//  CarroEntity+CoreDataProperties.swift
//  
//
//  Created by André Brilho on 20/12/19.
//
//

import Foundation
import CoreData


extension CarroEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarroEntity> {
        return NSFetchRequest<CarroEntity>(entityName: "CarroEntity")
    }

    @NSManaged public var desc: String?
    @NSManaged public var nome: String?
    @NSManaged public var url_foto: String?

}
