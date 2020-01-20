//
//  WorkoutDetailHeader.swift
//  GymBro
//
//  Created by Florian Dufter on 15.01.20.
//  Copyright © 2020 flocco. All rights reserved.
//

import SwiftUI

struct WorkoutDetailHeader: View {
    @State var workout: Workout
    let dateFormatter = DateFormatter()

    var body: some View {
        dateFormatter.dateStyle = .medium

        return ZStack {
            HStack {
                VStack {
                    Text(self.workout.name!)
                        .foregroundColor(Color("FrostTwo"))
                        .font(.headline)
                    Text("\(self.workout.date!, formatter: dateFormatter)").font(.subheadline).foregroundColor(Color.white)
                }
                Spacer()
                VStack {
                    HStack {
                        Text( (String(format: "%.0f", Double(workout.calculateMovedVol()*100))))
                            .font(.system(size: 33)).font(.largeTitle)
                            .foregroundColor(Color.red)
                        Text("points")

                    }
                }

            }
            .padding()
            .shadow(radius: 5.0)

        }
        .padding()
        .frame(width: 400, height: 200)
        .foregroundColor(.white)
        .background(Color.black)
        .cornerRadius(15)
        .padding()
        .shadow(radius: 5.0)

    }
}

struct WorkoutDetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        let workout = Workout()
        workout.name = "Workoutname"
        workout.date = Date.init()
        return WorkoutDetailHeader(workout: workout)
    }
}
