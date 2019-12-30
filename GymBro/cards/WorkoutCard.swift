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

    let cardColor = Color(hex: "138086")
    let cardColorFinish = Color(hex: "3C4CAD")
    let textColor = Color.white;
    
    
    var body: some View {
        formatter.dateStyle = .medium
        let dateString = self.formatter.string(from: workout.date!)
        let view = ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300.0, height: 140.0)
                .foregroundColor(.clear)
            .background(LinearGradient(gradient: Gradient(colors: [cardColor, cardColorFinish]), startPoint: .bottomLeading, endPoint: .topTrailing))
            .shadow(radius: 5.0)

            VStack(spacing: 20) {
                Text(workout.name!)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(textColor)
                Text(dateString)
                .foregroundColor(textColor)
            }
            VStack (spacing: 20){
                HStack {
                    Text("Click for more")
                        .foregroundColor(textColor)
                }
            }
        }
        return view
    }
}

struct WorkoutCard_Previews: PreviewProvider {
    static var previews: some View {
        let context = NSManagedObjectContext()
        return WorkoutCard(workout: createWorkout(context: context)).previewLayout(.sizeThatFits)
    }
}

func createWorkout(context: NSManagedObjectContext) -> Workout {
    let workout = Workout(context: context)
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
