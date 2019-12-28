//
//  Exercise.swift
//  GymBro
//
//  Created by Florian Dufter on 29.09.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import Foundation
import CoreData

enum ExerciseType: String {
    case squat = "Squat", deadlift = "Dead Lift" , benchpress = "Bench Press", shoulderpress = "Shoulder Press", militarypress = "Military Press"
}
public class Exercise: NSManagedObject, Identifiable {
    
    @NSManaged public var exerciseName: String?
    @NSManaged public var repetitions: NSNumber?
    @NSManaged public var weight: NSNumber?
    
}
