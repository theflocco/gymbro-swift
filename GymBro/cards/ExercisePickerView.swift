//
//  SampleView.swift
//  GymBro
//
//  Created by Florian Dufter on 24.12.19.
//  Copyright © 2019 flocco. All rights reserved.
//

import SwiftUI

struct ExercisePickerView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var didSelectExerciseType: (ExerciseType) -> ()
    @State var searchText = ""
    @State private var showCancelButton: Bool = false

    var body: some View {
        VStack {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    
                    TextField("search", text: self.$searchText, onEditingChanged: { isEditing in
                        self.showCancelButton = true
                    }, onCommit: {
                        print("onCommit")
                    }).foregroundColor(.primary)
                    
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(self.searchText == "" ? 0 : 1)
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)
                
                if showCancelButton  {
                    Button("Cancel") {
                        UIApplication.shared.endEditing()
                        self.searchText = ""
                        self.showCancelButton = false
                    }
                    .foregroundColor(Color(.systemBlue))
                }
            }
            .padding(.horizontal)
            .navigationBarHidden(showCancelButton)
            List(exerciseTypeData.filter{$0.rawValue.hasPrefix(searchText) || searchText == ""}, id: \.self) { exerciseType in
                HStack {
                    Button(action: {
                        self.didSelectExerciseType(exerciseType)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text(exerciseType.rawValue)
                    }
                    
                }
            }
        }
        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        
    }
    
}

struct ExercisePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisePickerView(didSelectExerciseType: {
            exerciseType in
            print(exerciseType)
        })
    }
}
extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
