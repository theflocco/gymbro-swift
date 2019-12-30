//
//  WorkoutDetailView.swift
//  GymBro
//
//  Created by Florian Dufter on 03.10.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import SwiftUI

struct WorkoutDetailView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var workout: Workout
    let dateFormatter = DateFormatter()
    
    
    var body: some View {
        dateFormatter.dateStyle = .medium
        var exerciseList = workout.exerciseList?.allObjects as! [Exercise]
        return NavigationView {
            ScrollView(showsIndicators: false) {
                Text("Workout " + workout.name!).bold()
                Text("\(workout.date!, formatter: dateFormatter)")
                ForEach(exerciseList, id: \.self) { (pickedExercise: Exercise) in
                    VStack {
                        ExerciseDetailCell(exercise: pickedExercise)
                    }
                }
                HStack {
                    Button(action: { self.presentation.wrappedValue.dismiss() }) { Text("Dismiss") }.keyboardResponsive()
                    Spacer()
                    Button(action: {
                        print("add button tapped")
                        let newExercise = Exercise(context: self.workout.managedObjectContext!)
                        newExercise.exerciseName = "Tap to edit"
                        newExercise.repetitions = 0
                        newExercise.sets = 0
                        newExercise.weight = 0
                        self.workout.addToExerciseList(newExercise)
                    }) {
                        Image(systemName: "plus.square.fill").scaleEffect(1.5)
                    }
                }.padding(.horizontal, 50)
            }
            
            
        }
        .navigationBarTitle("WorkoutDetailView")
    }

    func saveContext() {
        do {
            try self.managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}


struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = createWorkout()
        return WorkoutDetailView(workout: workout).previewLayout(.sizeThatFits)
    }
}
func createWorkout() -> Workout {
    let workout = Workout()
    workout.date = Date.init()
    workout.name = "Winter Smash"
    
    let exercise = Exercise()
    exercise.sets = 4
    exercise.repetitions = 10
    exercise.weight = 120
    exercise.exerciseName = ExerciseType.deadlift.rawValue
    
    workout.addToExerciseList(exercise)
    return workout
}
