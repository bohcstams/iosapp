//
//  AddExerciseView.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 30..
//

import SwiftUI

struct AddExerciseView: View {
    let groups : [MuscleGroup] = [
        MuscleGroup(name: "Back", types: ["Lat pulldown", "Pullups"]),
        MuscleGroup(name: "Shoulders", types: ["Dumbell shoulder press", "Lateral raises"]),
        MuscleGroup(name: "Chest", types: ["Bench press", "Peck deck"]),
    ]
    
    let onNewExercise : (String ) -> Void
        
    var body: some View {
        NavigationStack{
            List {
                ForEach(groups) { muscleGroup in
                    DisclosureGroup(muscleGroup.name) {
                        ForEach(muscleGroup.exerciseTypes, id: \.self) { exerciseType in
                            Button(action: {onNewExercise(exerciseType)}){
                                Text(exerciseType)
                                    .foregroundColor(.black)
                                    .padding(.leading)
                            }
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Select Exercise")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.yellow, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

#Preview {
    AddExerciseView(onNewExercise: {_ in })
}
