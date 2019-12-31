//
//  InfoView.swift
//  GymBro
//
//  Created by Florian Dufter on 30.12.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    let email = "support@ultrafluid.org"
    var body: some View {
        NavigationView {
            VStack {
                Text("UltraFluid.org")
                Button(action: {
                    if let url = URL(string: "mailto:\(self.email)") {
                      if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url)
                      } else {
                        UIApplication.shared.openURL(url)
                      }
                    }
                }) {
                    Text(self.email)
                }
            }

        }.navigationBarTitle("Info")
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView().previewLayout(.sizeThatFits)
    }
}
