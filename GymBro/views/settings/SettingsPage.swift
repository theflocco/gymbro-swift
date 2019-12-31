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
                    NavigationLink(destination: UserView(), label: {
                        Text("User")
                    })
                    NavigationLink(destination: InfoView(), label: {
                        Text("Info")
                    })                }
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
