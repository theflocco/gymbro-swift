//
//  UserView.swift
//  GymBro
//
//  Created by Florian Dufter on 30.12.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import SwiftUI
import CoreData

struct UserView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Workout.getAllWorkoutItems()) var workoutItems:FetchedResults<Workout>
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Workout")

    
    
    var body: some View {
        let count = try! managedObjectContext.count(for: fetchRequest) 
        return NavigationView {
            VStack {
                Spacer()
                List {
                    Text("Number of Workouts: " + count.description)
                    Text("iCloud sync enabled: false")
                }

            }
            
            }.navigationBarTitle("User")
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView().previewLayout(.sizeThatFits)
    }
}
