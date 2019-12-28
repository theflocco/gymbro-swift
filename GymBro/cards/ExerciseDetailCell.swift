//
//  WorkoutDetailCell.swift
//  GymBro
//
//  Created by Florian Dufter on 25.12.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import SwiftUI

struct ExerciseDetailCell: View {
    
    @State var exercise: Exercise
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 11)
                .foregroundColor(Color.blue)
            VStack(alignment: .center) {
                Text(exercise.exerciseName!)
                    .font(Font.headline)
                HStack {
                    VStack(alignment: HorizontalAlignment.leading) {
                        Text("Repetitions: ")
                        Text("Weight:")
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(exercise.repetitions!.description)
                        Text(exercise.weight!.description)
                    }
                    .font(Font.headline)
                    .foregroundColor(Color.black)
                }
            }
            .lineLimit(nil)
            .padding()
            .multilineTextAlignment(.center)
            .foregroundColor(Color.white)


        }.frame(width: 300.0, height: 120.0)
        .padding(.all)


    }
}

struct WorkoutDetailCell_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDetailCell(exercise: Exercise())
    }
}
