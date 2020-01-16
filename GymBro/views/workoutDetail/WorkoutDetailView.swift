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
    let tapCardsToEdit = NSLocalizedString("Tap cards to edit", comment: "")
    let tapMeToEdit = NSLocalizedString("Tap me to edit", comment: "")

    var body: some View {
        let exerciseList = workout.exerciseList?.allObjects as! [Exercise]
        return
            VStack {
                WorkoutDetailHeader(workout: workout)
                Spacer()
                ZStack(alignment: .bottomTrailing) {

                    ScrollView(showsIndicators: false) {

                        Text(tapCardsToEdit)
                            .font(.caption)
                            .foregroundColor(Color.gray)
                        ForEach(exerciseList, id: \.self) { (pickedExercise: Exercise) in
                            VStack {
                                ExerciseDetailCell(exercise: pickedExercise)
                            }
                        }
                        .padding(.bottom, CGFloat(20))
                    }
                    Button(action: {
                        let newExercise = Exercise(context: self.workout.managedObjectContext!)
                            newExercise.exerciseName = self.tapMeToEdit
                            self.workout.addToExerciseList(newExercise)
                        
                    }) {
                        HStack {
                                Image(systemName: "plus")
                            .font(Font.title.weight(.semibold))
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color("FrostOne"), Color("FrostTwo")]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(40)
                    .shadow(radius: CGFloat(5))
                        
                    }
                    .padding()
                .offset(x: 40)
                }

            }
            
            
        
        .navigationBarTitle(self.workout.name!)
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
