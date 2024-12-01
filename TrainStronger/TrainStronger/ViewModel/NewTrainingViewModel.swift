//
//  NewTrainingViewModel.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 30..
//

import Foundation

@Observable
class NewTrainingViewModel{
    var training : Training = Training(date: Date.now)
    var isEditing : Bool = false
    var isNewExercisePresented : Bool = false
    var isPopUpShowed : Bool = false
    var onFinish : (Training) -> Void = {_ in }
}
