//
//  WorkoutDetailCell.swift
//  GymBro
//
//  Created by Florian Dufter on 25.12.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import SwiftUI

struct ExerciseDetailCell: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State var exercise: Exercise
    @State private var repField: String = ""
    @State private var weightField: String = ""
    @State var inEditMode: Bool = false
    func save() {
        self.exercise.repetitions = Int(repField) as! NSNumber
        self.exercise.weight = Int(weightField) as! NSNumber
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }

    
    var body: some View {
        ZStack {
            if (inEditMode) {
                RoundedRectangle(cornerRadius: 11)
                    .foregroundColor(Color.orange)
            } else {
                RoundedRectangle(cornerRadius: 11)
                    .foregroundColor(Color.blue)
            }
            VStack(alignment: .center) {
                Text(exercise.exerciseName!)
                    .font(Font.headline)
                HStack {
                    VStack(alignment: HorizontalAlignment.leading) {
                        Text("Repetitions: ")
                        Text("Weight:")
                    }
                    .padding(.bottom, 8)
                    Spacer()
                    if (inEditMode) {
                        VStack(alignment: .trailing) {
                            TextField(exercise.repetitions!.description, text: self.$repField) {
                                    UIApplication.shared.endEditing()
                                self.inEditMode = false
                                self.save()
                            }.keyboardType(UIKeyboardType.numbersAndPunctuation)
                            .font(Font.headline)
                            .foregroundColor(Color.black)
                            TextField(exercise.repetitions!.description, text: self.$weightField) {
                                    UIApplication.shared.endEditing()
                                self.inEditMode = false
                                self.save()
                            }.keyboardType(UIKeyboardType.numbersAndPunctuation)
                            .font(Font.headline)
                            .foregroundColor(Color.black)
                        }
                    } else {
                        VStack(alignment: .trailing) {
                            Text(exercise.repetitions!.description)
                            Text(exercise.weight!.description)
                        }
                        .font(Font.headline)
                        .foregroundColor(Color.black)
                    }
                }
            }
        .onTapGesture(perform: {
            if (!self.inEditMode) {
                self.weightField = self.exercise.weight!.description
                self.repField = self.exercise.repetitions!.description
            }

            self.inEditMode = true
        })
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
