//
//  InfoView.swift
//  GymBro
//
//  Created by Florian Dufter on 30.12.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Made by UltraFluid")
                Text("Developer: Florian Dufter")


            }

        }.navigationBarTitle("Info")
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView().previewLayout(.sizeThatFits)
    }
}
