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
    let homepage = "www.ultrafluid.org"
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    if let url = URL(string: "http://\(self.homepage)") {
                        UIApplication.shared.open(url)
                      
                    }
                }) {
                    Text("UltraFluid.org")
                }.padding()
                Text("Please send feedback & bug reports to: ")
                Button(action: {
                    if let url = URL(string: "mailto:\(self.email)") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text(self.email)
                }.padding()
            }

        }.navigationBarTitle("Info")
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView().previewLayout(.sizeThatFits)
    }
}
