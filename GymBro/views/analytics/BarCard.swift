//
//  BarCard.swift
//  GymBro
//
//  Created by Florian Dufter on 20.01.20.
//  Copyright © 2020 flocco. All rights reserved.
//

import SwiftUI

struct BarCard: View {
    var body: some View {
        ZStack {
            Rectangle().foregroundColor(Color.white).frame(width: UIScreen.main.bounds.width - 12, height: 300)
                .cornerRadius(20)
            .shadow(radius: 5)
            HStack(alignment: .bottom, spacing: 8) {
                ForEach(percents) { i in
                        Bar(percent: i)

                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BarCard()
    }
}



struct Bar : View {
    @State var percent: type
    var body: some View {
        VStack {
            Text(String(format: "%.0f", percent.percent) + " %").foregroundColor(Color.black.opacity(0.5))
            Rectangle().fill(Color.red).frame(width: UIScreen.main.bounds.width / 7 - 12, height: getHeight())
            Text(percent.day).foregroundColor(Color.black.opacity(0.5))
        }
    }
    
    func getHeight() -> CGFloat {
        return 200/100*percent.percent
    }
}

struct type : Identifiable {
    
    var id: Int
    var percent: CGFloat
    var day: String
}

var percents = [
type(id: 1, percent: 35, day: "Mon"),
type(id: 2, percent: 55, day: "Tue"),
type(id: 3, percent: 75, day: "Wed"),
type(id: 4, percent: 25, day: "Thu"),
type(id: 5, percent: 59, day: "Fri"),
type(id: 6, percent: 61, day: "Sat"),
type(id: 7, percent: 100, day: "Sun"),
]
