//
//  ExerciseTypeEntity.swift
//  GymBro
//
//  Created by Florian Dufter on 31.12.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import Foundation
import CoreData

public class ExerciseTypeEntity: NSManagedObject, Identifiable {
    @NSManaged public var name: String?
}

extension ExerciseTypeEntity {
    
    static func getAllItems() -> NSFetchRequest<ExerciseTypeEntity> {
        let request: NSFetchRequest<ExerciseTypeEntity> = ExerciseTypeEntity.fetchRequest() as! NSFetchRequest<ExerciseTypeEntity>
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false);
        request.sortDescriptors = [sortDescriptor]
        return request
    }

    
}


