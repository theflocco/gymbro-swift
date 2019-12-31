//
//  WorkoutCard.swift
//  GymBro
//
//  Created by Florian Dufter on 29.09.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import SwiftUI
import CoreData


extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        
        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
        
    }
}

struct WorkoutCard: View {
    @State var workout: Workout
    let formatter = DateFormatter()
    let textColor = Color.white;
    let exercises = NSLocalizedString("exercises", comment: "")
    let exercise = NSLocalizedString("exercise", comment: "")
    
    var body: some View {
        formatter.dateStyle = .medium
        let dateString = self.formatter.string(from: workout.date!)
        let exerciseListSize = workout.exerciseList!.count
        let view = ZStack {
            VStack(spacing: 20) {
                Text(workout.name!)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(textColor)
                
                HStack {
                    Text(dateString)
                        .foregroundColor(textColor)
                    Spacer()
                    Text(workout.maxVolume!.description + " M")
                        .bold()
                        .foregroundColor(Color.orange)
                    Spacer()
                    Text(exerciseListSize > 1 ? exerciseListSize.description + " " + exercises : exerciseListSize.description + " " + exercise)
                        .foregroundColor(textColor)
                }
            }
            .frame(width: 300, height: 75.0)
            .shadow(radius: 5.0)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [Color("FrostTwo"), Color("FrostOne")]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(20)
            
        }
        .shadow(radius: 5)
        return view
    }
}

struct WorkoutCard_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutCard(workout: mockWorkout()).previewLayout(.sizeThatFits)
    }
}

func mockWorkout() -> Workout {
    let workout = Workout()
    workout.name = "Workout"
    workout.date = Date.init()
    let exercise = Exercise()
    exercise.exerciseName = "Exercise"
    exercise.repetitions = 10
    exercise.weight = 10
    workout.exerciseList = []
    workout.exerciseList?.adding(exercise)
    return workout
}
