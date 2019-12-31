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
    let yourWorkouts = NSLocalizedString("Your Workouts", comment: "")
    let WORKOUT_CARD_WIDTH: CGFloat = 350
    
    
    init() {
        UITableView.appearance().separatorColor = .clear
    }
    var body: some View {
        NavigationView {
            if (workoutItems.count == 0) {
                VStack {
                    Text("GymBro").bold().font(.largeTitle)
                    Text("Your personal Workout tracker!").font(.headline)
                    Spacer()
                    AddSomeWorkoutsCard()
                }
            } else {
            
                List {
                            ForEach(self.workoutItems, id: \.self ) { pickedWorkout in
                                
                                NavigationLink(destination: WorkoutDetailView(workout: pickedWorkout)) {
                                    WorkoutCard(workout: pickedWorkout)
                                }
                                
                            }.onDelete(perform: self.deleteItem)
                    .padding(.leading, (UIScreen.screenWidth-WORKOUT_CARD_WIDTH)/2)
                        
                }
                .navigationBarTitle(self.yourWorkouts)
                    
                .navigationBarItems(trailing:
                    EditButton()
                )
                    .navigationBarItems(leading: Button(action: {
                        
                    }) {
                        Text("Analytics")
                        .foregroundColor(Color("FrostTwo"))
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
