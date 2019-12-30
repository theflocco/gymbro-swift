//
//  Workout.swift
//  GymBro
//
//  Created by Florian Dufter on 29.09.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import Foundation
import CoreData

public class Workout: NSManagedObject, Identifiable {
    
    @NSManaged public var id: NSManagedObjectID?
    @NSManaged var name: String?
    @NSManaged var date: Date?
    @NSManaged var exerciseList: NSSet?
    
}

extension Workout {
    
    static func getAllWorkoutItems() -> NSFetchRequest<Workout> {
        let request: NSFetchRequest<Workout> = Workout.fetchRequest() as! NSFetchRequest<Workout>
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false);
        request.sortDescriptors = [sortDescriptor]
        return request
    }
    
    public func addEmptyExercise() {
        let exercise = Exercise()
        exerciseList?.adding(exercise)
    }
    
    @objc(addExerciseListObject:)
    @NSManaged public func addToExerciseList(_ value: Exercise)

    @objc(removeExerciseListObject:)
    @NSManaged public func removeFromExerciseList(_ value: Exercise)

    @objc(addExerciseList:)
    @NSManaged public func addToExerciseList(_ values: NSSet)

    @objc(removeExerciseList:)
    @NSManaged public func removeFromExerciseList(_ values: NSSet)
    
}
