//
//  UserView.swift
//  GymBro
//
//  Created by Florian Dufter on 30.12.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Username").font(.largeTitle)
                Text("Email Address").font(.subheadline)
                Spacer()
                List {
                        Text("Points: ").listRowBackground(Color.red)
                    Text("Premium: ").listRowBackground(Color.red)
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
