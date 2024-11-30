//
//  TrainingView.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 30..
//

import SwiftUI

struct TrainingView: View {
    @Environment(\.dismiss) var dismiss
    @State var training : Training
    @State var isNewExercisePresented : Bool = false
    @State var isPopUpShowed : Bool = false
    let onFinish: (Training) -> Void
    
    init(onFinish : @escaping (Training) -> Void, date : Date){
        self.onFinish = onFinish
        self.training = Training(date: date, exercises: [])
    }
    
    var body: some View {
        ZStack{
            NavigationStack{
                if training.exercises.isEmpty {
                    Spacer()
                    Text("Add exercises with plus button")
                        .foregroundColor(.gray)
                    Spacer()
                    .navigationTitle("Log training")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem{
                            Button(action: {isNewExercisePresented = true}) {
                                Label("Add Exercise", systemImage: "plus")
                            }
                        }
                    }
                }
                else{
                    ScrollView{
                        ForEach(Array($training.exercises.enumerated()), id: \.element.id){ index, $exercise in
                            VStack{
                                ExerciseView(exercise: exercise)
                                Button(action: {deleteExercise(at: index)}){
                                    Text("Delete exercise")
                                        .foregroundColor(.red)
                                }
                                .padding()
                                Divider()
                            }
                        }
                    }
                    .toolbar{
                        ToolbarItem{
                            Button(action: {isNewExercisePresented = true}) {
                                Label("Add Exercise", systemImage: "plus")
                            }
                        }
                        ToolbarItem{
                            Button(action: {
                                isPopUpShowed = true
                            }){
                                Text("Finish")
                            }
                        }
                    }
                    .navigationTitle("Log training")
                    .navigationBarTitleDisplayMode(.inline)
                }
                
            }
            .sheet(isPresented: $isNewExercisePresented){
                AddExerciseView(onNewExercise: addExercise)
            }
            
            if isPopUpShowed {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPopUpShowed = false
                    }
                savingPrompt()
                    .transition(.scale)
            }
        }
    }
    
    private func deleteExercise(at offset: Int){
        training.exercises.remove(at: offset)
    }
    
    private func addExercise(withName name : String){
        isNewExercisePresented = false
        let newExercise = Exercise(name: name)
        training.exercises.append(newExercise)
    }
    
    @ViewBuilder
    private func savingPrompt() -> some View{
        VStack{
            Text("Give a name for your training")
                .bold()
            TextField("Training name", text: $training.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(width: 250)
            Button(action : {
                onFinish(training)
                isPopUpShowed = false
                dismiss()
            }){
                Text("Finish")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .cornerRadius(10)
            }
        }
        .frame(width: 300, height: 250)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

#Preview {
    TrainingView(onFinish: {_ in}, date : Date.now)
}
