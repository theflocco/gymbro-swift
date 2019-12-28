//
//  WorkoutView.swift
//  GymBro
//
//  Created by Florian Dufter on 29.09.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import SwiftUI

struct WorkoutHistoryView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Workout.getAllWorkoutItems()) var workoutItems: FetchedResults<Workout>
    @State private var showModal: Bool = false;
    init() {
          UITableView.appearance().separatorColor = .clear
      }
    var body: some View {
        
        NavigationView {
                    
            List {
                ForEach(workoutItems, id: \.self ) { pickedWorkout in
                    VStack {
                        Button(action: {
                            self.showModal.toggle()
                        }) {
                            WorkoutCard(workout: pickedWorkout).padding(.leading, 20)
                        }.sheet(isPresented: self.$showModal, onDismiss: {
                            self.showModal = false
                        }, content: {
                            return WorkoutDetailView(workout: pickedWorkout)
                            })
                    }

                    }.onDelete(perform: deleteItem)
            }
            .navigationBarTitle("Your Workouts")

            .navigationBarItems(trailing: NavigationLink(destination: AddWorkoutView(submittedExercises: [])) {
                Image(systemName: "plus")
                    .font(.headline)

            })
                    

                }

    }
    
    func deleteItem(indexSet: IndexSet) {
        let source = indexSet.first!
        let item = workoutItems[source]
        managedObjectContext.delete(item)
        saveItems()
    }
    
    func saveItems() {
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    

}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutHistoryView()
    }
}
