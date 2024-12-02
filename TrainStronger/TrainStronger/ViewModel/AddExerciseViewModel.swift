//
//  AddExerciseViewModel.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 12. 02..
//

import Foundation

class AddExerciseViewModel: ObservableObject{
    @Published var searchText = ""
    @Published var isPopUpDisplayed : Bool = false
    @Published var newType = ""
    
    func filterGroups(muscleGroups : [MuscleGroup]) -> [MuscleGroup]{
        if searchText.isEmpty{
            return muscleGroups
        }
        else{
            return muscleGroups.compactMap { group in
                let filteredTypes = group.exerciseTypes.filter { type in
                    type.type.lowercased().contains(searchText.lowercased())
                }
                if !filteredTypes.isEmpty {
                    return MuscleGroup(name: group.name, types: filteredTypes.map { $0.type })
                } else {
                    return nil
                }
            }
        }
    }
}
