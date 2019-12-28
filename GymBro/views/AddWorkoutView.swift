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
                HStack {
                    Text("Workout name: ")
                        .font(.headline)
                        .padding()
                    TextField("Name your workout", text: self.$workoutName) {
                        UIApplication.shared.endEditing()
                    }
                }
                
                VStack {
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
                    
                    HStack {
                        Text("Repetitions: ")
                            .font(.headline)
                            .padding()
                        TextField("Add Repetitions", text: self.$repetitions) {
                            UIApplication.shared.endEditing()
                        }
                        .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("Weight: ")
                            .font(.headline)
                            .padding()
                        TextField("Add Weight", text: self.$weight) {
                            UIApplication.shared.endEditing()
                        }
                        .keyboardType(.default)
                        
                    }
                    Button(action: {
                        if (!self.repetitions.isEmpty && !self.weight.isEmpty) {
                            if let unwrappedExerciseType = self.pickedExerciseType {
                                self.submittedExercises.append(submitExercise(repetitions: self.repetitions, weight: self.weight, pickedExerciseType: unwrappedExerciseType, managedObjectContext: self.managedObjectContext))
                            }
                        } else {
                            self.showingAlert = true
                        }

                    }) {
                    
                        Image(systemName: "plus.app.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                        
                    }.alert(isPresented: $showingAlert) {
                        Alert(title: Text("Important message"), message: Text("Pick an exercise & fill in repetitions & weight"), dismissButton: .default(Text("Got it!")))
                    }
                }
                if submittedExercises.count > 0 {
                    VStack {
                        ForEach(submittedExercises, id: \.self) {
                            (submittedExercise: Exercise) in
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 300, height: 100)
                                    .foregroundColor(.clear)
                                    .background(Color.blue)
                                    .shadow(radius: 5.0)
                                VStack {
                                    Text(submittedExercise.exerciseName!)
                                        .bold()
                                    HStack {
                                        Text("Reps: "); Text(submittedExercise.repetitions!.description)
                                    }
                                    HStack {
                                        Text("Weight: "); Text(submittedExercise.weight!.description)
                                    }
                                    
                                }
                            }
                            .scaleEffect(x: 1, y: -1, anchor: .center)
                        }.onDelete(perform: deleteItem)
                        
                        
                    }.scaleEffect(x: 1, y: -1, anchor: .center)
                    
                    
                }
                
                
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



func submitExercise(repetitions: String, weight: String, pickedExerciseType: ExerciseType, managedObjectContext: NSManagedObjectContext) -> Exercise {
    // TODO: not nullsafe
    let newExercise = Exercise(context: managedObjectContext)
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
