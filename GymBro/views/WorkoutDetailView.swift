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
    var workout: Workout
    let dateFormatter = DateFormatter()

    
    var body: some View {
        dateFormatter.dateStyle = .medium
        let exerciseList = workout.exerciseList?.allObjects as! [Exercise]
        return NavigationView {
            ScrollView(showsIndicators: false) {
                Text("Workout " + workout.name!).bold()
                Text("\(workout.date!, formatter: dateFormatter)")
                ForEach(exerciseList, id: \.self) { (exercise: Exercise) in
                    VStack {
                        ExerciseDetailCell(exercise: exercise)
                    }
                }
                Button(action: { self.presentation.wrappedValue.dismiss() }) { Text("Dismiss") }

            }
        
        }
    .navigationBarTitle("WorkoutDetailView")
    }
}

//struct WorkoutDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        WorkoutDetailView(workoutName: "workoutName", description: "Description", date: Date.init())
//    }
//}
