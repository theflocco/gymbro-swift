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
    @State private var weightField: String = ""
    @State var inEditMode: Bool = false
    @State var pickedExerciseType: String = ""
    @State var showModal: Bool = false
    
    let SMALL_FONT_SIZE: CGFloat = 22
    
    
    func save() {
        self.exercise.exerciseName = self.pickedExerciseType
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
                    .foregroundColor(Color("FrostTwo"))
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
                        
                        Button(action: {
                            self.showModal = true
                        }) {
                            Text(self.pickedExerciseType).font(.system(size: 26)).bold()
                        }.sheet(isPresented: self.$showModal, content: {
                            ExercisePickerView(didSelectExerciseType: { exerciseType in
                                print(exerciseType)
                                self.pickedExerciseType = exerciseType
                            }).environment(\.managedObjectContext, self.managedObjectContext)
                        })
                        
                        
                        Button(action: {
                            print("delete pressed")
                            self.exercise.managedObjectContext?.delete(self.exercise)
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
                        Text("Weight (kg)")
                    }
                    .font(.system(size: SMALL_FONT_SIZE))
                    .padding(.bottom, 8)
                    Spacer()
                    if (inEditMode) {
                        VStack(alignment: .trailing) {
                            
                            TextField(exercise.sets!.description, text: self.$setField) {
                                UIApplication.shared.endEditing()
                            }.keyboardType(.numberPad)
                                .font(.headline)
                                .foregroundColor(Color.black)

                            TextField(exercise.repetitions!.description, text: self.$repField) {
                                UIApplication.shared.endEditing()
                            }.keyboardType(.numberPad)
                                .font(.headline)
                                .foregroundColor(Color.black)

                            TextField(exercise.weight!.description, text: self.$weightField) {
                                UIApplication.shared.endEditing()

                            }.keyboardType(.numberPad)
                                .font(.headline)
                                .foregroundColor(Color.black)

                        }
                    } else {
                        VStack(alignment: .trailing) {
                            Text(exercise.sets!.description).bold()
                            Text(exercise.repetitions!.description).bold()
                            Text(exercise.weight!.description).bold()
                        }
                        .font(.headline)
                        .foregroundColor(Color.white)
                    }
                }
            }
            .onTapGesture(perform: {
                if (!self.inEditMode) {
                    self.pickedExerciseType = self.exercise.exerciseName!.description
                    self.setField = self.exercise.sets!.description
                    self.weightField = self.exercise.weight!.description
                    self.repField = self.exercise.repetitions!.description
                    self.inEditMode = true

                }
                
            })
                .lineLimit(nil)
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
            
            
        }
        .shadow(radius: CGFloat(5))
        .frame(width: 300.0, height: 140.0)
        
        
    }
}

//struct WorkoutDetailCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseDetailCell(exercise: Exercise())
//    }
//}
