//
//  AddSomeWorkoutsCard.swift
//  GymBro
//
//  Created by Florian Dufter on 31.12.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import SwiftUI

struct AddSomeWorkoutsCard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
            .padding()
                VStack {
                    Text("Add some Workouts!")
                        .bold().font(.system(size: 22)).foregroundColor(Color.white)
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.white)
                        .font(.system(size: 30, weight: .light))
                }
            .padding(.bottom,3)

        }
        .foregroundColor(Color("FrostTwo"))
        .frame(width: 320, height: 100)
        
    }
}

struct AddSomeWorkoutsCard_Previews: PreviewProvider {
    static var previews: some View {
        AddSomeWorkoutsCard().previewLayout(.sizeThatFits)
    }
}
