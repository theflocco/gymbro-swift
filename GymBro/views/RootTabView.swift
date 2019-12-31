//
//  RootTabView.swift
//  GymBro
//
//  Created by Florian Dufter on 25.12.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import SwiftUI

struct RootTabView: View {
    @State var selectedView = 0
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var showModal = false

    var body: some View {
        TabView(selection: $selectedView) {
            WorkoutHistoryView().environment(\.managedObjectContext, managedObjectContext)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Log")
                }.tag(0)
            WorkoutHistoryView().environment(\.managedObjectContext, managedObjectContext)
                .onAppear {
                    print("Hallo")
                    DispatchQueue.main.async {
                        self.showModal = true
                    }
                }
                .tabItem {
                    VStack {
                        Image(systemName: "plus.rectangle.fill")
                        Text("Add Workout")
                    }
            }.tag(1)
                .onTapGesture {
                    self.showModal.toggle()
            }
            SettingsPage()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
            }.tag(2)
        }
        .sheet(isPresented: self.$showModal) { AddWorkoutView(submittedExercises: []).environment(\.managedObjectContext, self.managedObjectContext)
            .onAppear() {
                print("modal disappeared")
                self.selectedView = 0
            }
        }
        
    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
    }
}
