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

    //@Binding var workoutTitle: String
    //@Binding var workoutDate: String
    //@Binding var workoutPoints: String
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
                        Text( (workout.calculateMovedVol()*100).description)
                            .font(.system(size: 26)).font(.largeTitle)
                            .foregroundColor(Color.red)
                        Text("points")

                    }
                }

            }
            .padding()
            .shadow(radius: 5.0)

        }
        .padding()
        .foregroundColor(.white)
        .background(Color.black)
        .cornerRadius(15)
        .padding()
        .shadow(radius: 5.0)

    }
}

struct WorkoutDetailHeader_Previews: PreviewProvider {
    static var previews: some View {
        return Text("Hi")
       // WorkoutDetailHeader(workoutTitle: .constant("Crusher Workout"), workoutDate: .constant("Dec 31, 2019"), workoutPoints: .constant("7"))
    }
}
