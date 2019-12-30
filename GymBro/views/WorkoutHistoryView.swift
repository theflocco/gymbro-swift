//
//  WorkoutView.swift
//  GymBro
//
//  Created by Florian Dufter on 29.09.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import SwiftUI

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

struct WorkoutHistoryView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Workout.getAllWorkoutItems()) var workoutItems: FetchedResults<Workout>
    @State private var showModal: Bool = false;
    
    let WORKOUT_CARD_WIDTH: CGFloat = 300
    
    
    init() {
        UITableView.appearance().separatorColor = .clear
    }
    var body: some View {
        NavigationView {
            if (workoutItems.count == 0) {
                Text("Add some Workouts!")
                    .bold().font(.largeTitle)
            } else {
            
                List {
                        VStack(alignment: .center) {
                            ForEach(self.workoutItems, id: \.self ) { pickedWorkout in
                                Button(action: {
                                    self.showModal.toggle()
                                }) {
                                    WorkoutCard(workout: pickedWorkout)
                                        .deleteDisabled(true)
                                }.sheet(isPresented: self.$showModal, onDismiss: {
                                    self.showModal = false
                                }, content: {
                                    return WorkoutDetailView(workout: pickedWorkout)
                                })
                                
                                
                            }.onDelete(perform: self.deleteItem)
                        }.padding(.leading, (UIScreen.screenWidth-WORKOUT_CARD_WIDTH)/2)
                }
                .navigationBarTitle("Your Workouts")
                    
                .navigationBarItems(trailing:
                    EditButton()
                )
                    .navigationBarItems(leading: Button(action: {
                        
                    }) {
                        Text("Analytics")
                    })
            }
            
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
