//
//  ExerciseView.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 30..
//

import SwiftUI

struct ExerciseView: View {
    @Bindable var exercise : Exercise
    let editable: Bool
    
    var body: some View {
        VStack{
            Text(exercise.name)
                .bold()
                .padding()
            if !exercise.sets.isEmpty {
                HStack(spacing: 90){
                    Text("Repetitions")
                    Text("Weight (kg)")
                }
                .padding(.horizontal)
            }
            ForEach(Array($exercise.sets.enumerated()), id: \.element.id) { index, $set in
                HStack{
                    SetView(set: set, editable: editable)
                    if editable{
                        Button(action: {deleteSet(at: index)}){
                            Image(systemName: "trash.fill")
                            .foregroundColor(.red)
                            .padding()
                        }
                    }
                }
                
            }
            if editable {
                Button(action: addNewSet) {
                    Text("Add new set")
                }
                .padding(.top, 8)
            }
        }
    }
    
    private func addNewSet(){
        let lastSet = exercise.sets.last
        let newSet : Set = Set(weight: lastSet?.weight ?? 0, reps: lastSet?.repetitions ?? 0)
        exercise.sets.append(newSet)
    }
    
    private func deleteSet(at offset: Int) {
        exercise.sets.remove(at: offset)
    }
}

struct ExerciseView_Previews : PreviewProvider{
    @State static var exercise : Exercise = Exercise(name: "Lat pulldown", sets: [
        Set(weight: 0, reps: 0),
        Set(weight: 12.5, reps: 5)
    ])
    static var previews: some View {
        ExerciseView(exercise: exercise, editable: true)
    }
}
