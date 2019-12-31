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
    @State var pickedExerciseType: String?
    @State private var exercisePicked: Bool = false
    @State var submittedExercises: [Exercise]
    @State private var showingAlert = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let FONT_SIZE : CGFloat = 22
    let ADD_A_NEW_WORKOUT = NSLocalizedString("Add a new Workout", comment: "")
    let SELECT_EXERCISE = NSLocalizedString("Select exercise", comment: "")
    let WORKOUT_NAME = NSLocalizedString("Workout name", comment: "")
    let REPETITIONS = NSLocalizedString("Repetitions", comment: "")
    let WEIGHT = NSLocalizedString("Weight (lbs)", comment: "")
    let SAVE = NSLocalizedString("Save", comment: "")
    
    func submitWorkout() {
        createWorkout(workoutName: self.workoutName, repetitions: self.repetitions, weight: self.weight, managedObjectContext: self.managedObjectContext, exerciseList: submittedExercises)
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func deleteItem(indexSet: IndexSet) {
        self.submittedExercises.remove(at: indexSet.first!)
    }
    
    fileprivate func cleanUpAndResign() {
        UIApplication.shared.endEditing()
        
        self.exercisePicked = false
        self.repetitions = ""
        self.weight = ""
        self.sets = ""
    }
    
    var body: some View {
        return NavigationView {
            ScrollView {
                Button(action: {
                    self.showModal.toggle()
                }) {
                    if exercisePicked {
                        Text(self.pickedExerciseType!)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    } else {
                        HStack {
                            Image(systemName: "tag")
                                .font(.headline)
                            Text(SELECT_EXERCISE)
                                .fontWeight(.semibold)
                                .font(.headline)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("FrostOne"), Color("FrostTwo")]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                    .shadow(radius: 5)
                    }
                }.sheet(isPresented: self.$showModal, content: {
                    ExercisePickerView(didSelectExerciseType: { exerciseType in
                        print(exerciseType)
                        self.pickedExerciseType = exerciseType
                        self.exercisePicked = true
                        
                    }).environment(\.managedObjectContext, self.managedObjectContext)
                })
                
                VStack(alignment: .center) {
                    HStack {
                        VStack(alignment: HorizontalAlignment.leading) {
                            Text(WORKOUT_NAME)
                                .font(.system(size: FONT_SIZE, weight: .bold, design: .default))
                                .padding(.bottom, 8)
                            Text("Sets")
                                .font(.system(size: FONT_SIZE))
                                .padding(.bottom, 8)
                            Text(REPETITIONS)
                                .font(.system(size: FONT_SIZE))
                                .padding(.bottom, 8)
                            Text(WEIGHT)
                                .font(.system(size: FONT_SIZE))
                                .padding(.bottom, 8)
                        }
                        .padding(.leading, 8)
                        Spacer()
                        VStack(alignment: HorizontalAlignment.trailing) {
                            TextField("Add name", text: self.$workoutName) {
                                UIApplication.shared.endEditing()
                                
                            }.font(.system(size: FONT_SIZE, weight: .bold, design: .default))
                            TextField("Add sets", text: self.$sets) {
                                UIApplication.shared.endEditing()
                            }.font(.system(size: FONT_SIZE))
                                .keyboardType(.numberPad)
                            
                            TextField("Add repetitions", text: self.$repetitions) {
                                UIApplication.shared.endEditing()
                            }.font(.system(size: FONT_SIZE))
                                .keyboardType(.numberPad)
                            TextField("Add weight", text: self.$weight) {
                                UIApplication.shared.endEditing()
                            }.font(.system(size: FONT_SIZE))
                                .keyboardType(.numberPad)
                        }
                        .multilineTextAlignment(.leading)
                            
                        .padding()
                        
                    }
                    
                }
                .padding()
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
                    self.cleanUpAndResign()
                    
                }) {
                    HStack {
                        Image(systemName: "plus.square.fill.on.square.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                        Text("Add entry")
                    }

                    
                }.alert(isPresented: $showingAlert) {
                    Alert(title: Text("Important message"), message: Text("Pick an exercise & fill in sets, repetitions & weight"), dismissButton: .default(Text("Got it!")))
                }.padding(.bottom, 8)
                if submittedExercises.count > 0 {
                    VStack {
                        ForEach(submittedExercises, id: \.self) {
                            (submittedExercise: Exercise) in
                            ZStack {
                                
                                
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
                                
                                
                            }
                        }.onDelete(perform: deleteItem)
                            .frame(width: 300, height: 100)
                            .shadow(radius: 5.0)
                            .foregroundColor(.white)
                            .background(LinearGradient(gradient: Gradient(colors: [Color("DeepSpaceOne"), Color("DeepSpaceTwo")]), startPoint: .leading, endPoint: .trailing))
                            .scaleEffect(x: 1, y: -1, anchor: .center)
                            .cornerRadius(20)
                            .padding()
                    }.scaleEffect(x: 1, y: -1, anchor: .center)
                    
                    
                }
                
                
            }
                
            .navigationBarTitle(ADD_A_NEW_WORKOUT)
            .navigationBarItems(trailing:
                Button(action: {
                    if (!self.workoutName.isEmpty) {
                        self.submitWorkout()
                    } else {
                        self.showingAlert = true
                    }
                }) {
                    Text(SAVE)
            })
            
            
        }
    }
}



func submitExercise(sets: String, repetitions: String, weight: String, pickedExerciseType: String, managedObjectContext: NSManagedObjectContext) -> Exercise {
    let newExercise = Exercise(context: managedObjectContext)
    newExercise.sets = Int(sets) as NSNumber?
    newExercise.exerciseName = pickedExerciseType
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
