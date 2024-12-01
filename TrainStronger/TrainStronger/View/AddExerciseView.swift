//
//  AddExerciseView.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 30..
//

import SwiftUI
import SwiftData

struct AddExerciseView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \MuscleGroup.name, order: .forward) private var muscleGroups : [MuscleGroup]
    @State private var searchText = ""
    
    var groupsFiltered : [MuscleGroup] {
        if searchText.isEmpty{
            return muscleGroups
        }
        else{
            return muscleGroups.compactMap { group in
                let filteredTypes = group.exerciseTypes.filter { type in
                    type.type.contains(searchText)
                }
                if !filteredTypes.isEmpty {
                    return MuscleGroup(name: group.name, types: filteredTypes.map { $0.type })
                } else {
                    return nil
                }
            }
        }
    }
    
    let onNewExercise : (String ) -> Void
        
    var body: some View {
        NavigationStack{
            TextField("Search the name of exercise", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            List {
                ForEach(groupsFiltered) { muscleGroup in
                    DisclosureGroup(muscleGroup.name) {
                        ForEach(muscleGroup.exerciseTypes.sorted{ $0.type < $1.type }, id: \.self) { exerciseType in
                            Button(action: {onNewExercise(exerciseType.type)}){
                                Text(exerciseType.type)
                                    .foregroundColor(.primary)
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
