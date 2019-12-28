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

    var body: some View {
        TabView(selection: $selectedView) {
            WorkoutHistoryView().environment(\.managedObjectContext, managedObjectContext)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("First")
                }.tag(0)
                Text("@FlorianDufter")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }.tag(1)
        }    }
}

struct RootTabView_Previews: PreviewProvider {
    static var previews: some View {
        RootTabView()
    }
}
