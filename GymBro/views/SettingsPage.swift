//
//  SettingsPage.swift
//  GymBro
//
//  Created by Florian Dufter on 29.12.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import SwiftUI

struct SettingsPage: View {
    var body: some View {
        NavigationView {

                List {
                    Text("User")
                    Text("Premium")
                    Text("Metrics")
                    Text("Info")
                }
            .padding(.leading, 50)
            .navigationBarTitle("Settings")

            }
        }

}

struct SettingsPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPage()
    }
}
