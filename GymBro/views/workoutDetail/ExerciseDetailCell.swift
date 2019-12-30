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
    @State private var setField: String = ""
    @State private var repField: String = ""
    @State private var exerciseNameField: String = ""
    @State private var weightField: String = ""
    @State var inEditMode: Bool = false
    
    let SMALL_FONT_SIZE: CGFloat = 22
    
    
    func save() {
        self.exercise.exerciseName = exerciseNameField
        self.exercise.sets = Int(setField) as! NSNumber
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
                if (inEditMode) {
                    HStack {
                        Button(action: {
                            print("edit mode toggled")
                            self.inEditMode = false
                            UIApplication.shared.endEditing()
                            self.save()
                        }) {
                            Image(systemName: "checkmark.circle.fill")
                        }
                        
                        TextField(exercise.exerciseName!.description, text: self.$exerciseNameField) {
                            UIApplication.shared.endEditing()
                            self.inEditMode = false
                            self.save()
                        }
                        .font(.system(size: 26))
                        
                        
                        Button(action: {
                            print("delete pressed")
                            self.exercise.managedObjectContext?.delete(self.exercise)
                            UIApplication.shared.endEditing()
                            self.save()
                        }) {
                            Image(systemName: "minus.circle")
                        }
                    }
                } else {
                    Text(exercise.exerciseName!)
                        .font(.system(size: 26))
                        .bold()
                    
                }
                
                HStack {
                    VStack(alignment: HorizontalAlignment.leading) {
                        Text("Sets")
                        Text("Repetitions")
                        Text("Weight")
                    }
                    .font(.system(size: SMALL_FONT_SIZE))
                    .padding(.bottom, 8)
                    Spacer()
                    if (inEditMode) {
                        VStack(alignment: .trailing) {
                            TextField(exercise.sets!.description, text: self.$setField) {
                                UIApplication.shared.endEditing()
                                self.inEditMode = false
                                self.save()
                            }.keyboardType(UIKeyboardType.numbersAndPunctuation)
                                .font(.system(size: SMALL_FONT_SIZE))
                                .foregroundColor(Color.black)
                            
                            
                            TextField(exercise.repetitions!.description, text: self.$repField) {
                                UIApplication.shared.endEditing()
                                self.inEditMode = false
                                self.save()
                            }.keyboardType(UIKeyboardType.numbersAndPunctuation)
                                .font(.system(size: SMALL_FONT_SIZE))
                                .foregroundColor(Color.black)
                            
                            TextField(exercise.repetitions!.description, text: self.$weightField) {
                                UIApplication.shared.endEditing()
                                self.inEditMode = false
                                self.save()
                            }.keyboardType(UIKeyboardType.numbersAndPunctuation)
                                .font(.system(size: SMALL_FONT_SIZE))
                                .foregroundColor(Color.black)
                        }
                    } else {
                        VStack(alignment: .trailing) {
                            Text(exercise.sets!.description)
                            Text(exercise.repetitions!.description)
                            Text(exercise.weight!.description)
                        }
                        .font(.system(size: SMALL_FONT_SIZE))
                        .foregroundColor(Color.black)
                    }
                }
            }
            .onTapGesture(perform: {
                if (!self.inEditMode) {
                    self.exerciseNameField = self.exercise.exerciseName!.description
                    self.setField = self.exercise.sets!.description
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
            .padding(.all, 20)
        
        
    }
}

//struct WorkoutDetailCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseDetailCell(exercise: Exercise())
//    }
//}
