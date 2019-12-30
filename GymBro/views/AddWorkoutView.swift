//
//  AddWorkout.swift
//  GymBro
//
//  Created by Florian Dufter on 29.09.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import SwiftUI
import CoreData


struct AddWorkoutView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var workoutName: String = ""
    @State private var exerciseTitle: String = ""
    @State private var repetitions: String = ""
    @State private var weight: String = ""
    @State private var sets: String = ""
    @State private var didTap: Bool = false
    @State private var showModal = false
    @State var pickedExerciseType: ExerciseType?
    @State private var exercisePicked: Bool = false
    @State var submittedExercises: [Exercise]
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    func submitWorkout() {
        let newWorkout = createWorkout(workoutName: self.workoutName, repetitions: self.repetitions, weight: self.weight, managedObjectContext: self.managedObjectContext, exerciseList: submittedExercises)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func deleteItem(indexSet: IndexSet) {
        self.submittedExercises.remove(at: indexSet.first!)
    }
    
    var body: some View {
        return NavigationView {
                ScrollView {
                    Button(action: {
                        self.showModal.toggle()
                    }) {
                        if exercisePicked {
                            Text(self.pickedExerciseType!.rawValue)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        } else {
                            
                            Text("Select Exercise")
                        }
                    }.sheet(isPresented: self.$showModal, content: {
                        ExercisePickerView(didSelectExerciseType: { exerciseType in
                            print(exerciseType)
                            self.pickedExerciseType = exerciseType
                            self.exercisePicked = true
                            
                        })
                    })
                    VStack(alignment: .center) {
                        HStack {
                            VStack(alignment: HorizontalAlignment.leading) {
                                Text("Workout name: ")
                                    .font(.headline)
                                    .padding(.bottom, 8)
                                Text("Sets: ")
                                    .font(.headline)
                                    .padding(.bottom, 8)
                                    Text("Repetitions: ")
                                        .font(.headline)
                                        .padding(.bottom, 8)
                                    Text("Weight: ")
                                        .font(.headline)
                                        .padding(.bottom, 8)
                            }
                            .padding(.leading, 8)
                            Spacer()
                            VStack(alignment: HorizontalAlignment.trailing) {
                                TextField("Name your workout", text: self.$workoutName) {
                                    UIApplication.shared.endEditing()
                                    
                                }
                                TextField("Add Sets", text: self.$sets) {
                                    UIApplication.shared.endEditing()
                                }
                                .keyboardType(.numberPad)
                                
                                TextField("Add Repetitions", text: self.$repetitions) {
                                    UIApplication.shared.endEditing()
                                }
                                    
                                .keyboardType(.numberPad)
                                TextField("Add Weight", text: self.$weight) {
                                    UIApplication.shared.endEditing()
                                }
                                .keyboardType(.numberPad)
                            }
                            .padding()

                        }

                    }
                    .lineLimit(nil)
                    .multilineTextAlignment(.center)
                    Button(action: {
                        if (!self.repetitions.isEmpty && !self.weight.isEmpty && !self.sets.isEmpty && !(self.pickedExerciseType == nil)) {
                            if let unwrappedExerciseType = self.pickedExerciseType {
                                self.submittedExercises.append(submitExercise(sets: self.sets, repetitions: self.repetitions, weight: self.weight, pickedExerciseType: unwrappedExerciseType, managedObjectContext: self.managedObjectContext))
                            }
                        } else {
                            self.showingAlert = true
                        }

                    }) {
                    
                        Image(systemName: "plus.square.fill.on.square.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                        
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text("Important message"), message: Text("Pick an exercise & fill in sets, repetitions & weight"), dismissButton: .default(Text("Got it!")))
                    }.padding(.bottom, 8)
                    if submittedExercises.count > 0 {
                        VStack {
                            ForEach(submittedExercises, id: \.self) {
                                (submittedExercise: Exercise) in
                                ZStack {
                                    RoundedRectangle(cornerRadius: 11)
                                    .foregroundColor(Color.blue)

                                    VStack {
                                        Text(submittedExercise.exerciseName!)
                                            .bold()
                                        HStack {
                                            Text(submittedExercise.sets!.description + "x" + submittedExercise.repetitions!.description)
                                        }
                                        HStack {
                                            Text(submittedExercise.weight!.description + " kg")
                                        }
                                        
                                    }
                                }.frame(width: 300, height: 100)
                                    .shadow(radius: 5.0)

                                .scaleEffect(x: 1, y: -1, anchor: .center)
                            }.onDelete(perform: deleteItem)
                            
                            
                        }.scaleEffect(x: 1, y: -1, anchor: .center)
                        
                        
                    }
                    
                    
                }

            .navigationBarTitle("Add a new Workout")
            .navigationBarItems(trailing:
                Button(action: {
                    self.submitWorkout()
                }) {
                    Text("Save")
            })
            
            
        }
    }
}



func submitExercise(sets: String, repetitions: String, weight: String, pickedExerciseType: ExerciseType, managedObjectContext: NSManagedObjectContext) -> Exercise {
    let newExercise = Exercise(context: managedObjectContext)
    newExercise.sets = Int(sets) as NSNumber?
    newExercise.exerciseName = pickedExerciseType.rawValue
    newExercise.repetitions = Int(repetitions) as NSNumber?
    newExercise.weight = Int(weight) as NSNumber?
    return newExercise
}

func insertIntoSet(of workout: Workout, from exerciseList: [Exercise]) {
    var set = workout.exerciseList!
    let mutableCopy = set.mutableCopy() as! NSMutableSet
    mutableCopy.addObjects(from: exerciseList)
    set = mutableCopy
    workout.exerciseList = set
}

func createWorkout(workoutName: String, repetitions: String, weight: String, managedObjectContext: NSManagedObjectContext,
                   exerciseList: Array<Exercise>) -> Workout {
    let workout = Workout(context: managedObjectContext)
    workout.date = Date.init()
    workout.name = workoutName
    
    insertIntoSet(of: workout, from: exerciseList)
    
    do {
        try managedObjectContext.save()
    } catch {
        print(error)
    }
    return workout
}


struct AddWorkout_Previews: PreviewProvider {
    static var previews: some View {
        let exercise = Exercise()
        exercise.exerciseName = "name"
        exercise.weight = 1
        exercise.repetitions = 1
        var exerciseList: [Exercise] = []
        exerciseList.append(exercise)
        return AddWorkoutView(submittedExercises: exerciseList)
    }
}
