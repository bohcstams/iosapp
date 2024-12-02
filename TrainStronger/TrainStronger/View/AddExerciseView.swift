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
    @ObservedObject var viewModel = AddExerciseViewModel()
    let onNewExercise : (String ) -> Void
        
    var body: some View {
        ZStack{
            NavigationStack{
                TextField("Search the name of exercise", text: $viewModel.searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .padding(.top)
                List {
                    ForEach(viewModel.filterGroups(muscleGroups: muscleGroups)) { muscleGroup in
                        DisclosureGroup(muscleGroup.name) {
                            ForEach(muscleGroup.exerciseTypes.sorted{ $0.type < $1.type }, id: \.self) { exerciseType in
                                Button(action: {onNewExercise(exerciseType.type)}){
                                    Text(exerciseType.type)
                                        .foregroundColor(.primary)
                                        .padding(.leading)
                                }
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Select Exercise")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(.yellow, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar{
                    ToolbarItem{
                        Button(action: {viewModel.isPopUpDisplayed = true}) {
                            Image(systemName: "plus.circle")
                                    .foregroundColor(.black)
                        }
                    }
                }
            }
            
            if viewModel.isPopUpDisplayed {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        viewModel.isPopUpDisplayed = false
                    }
                newTypePrompt()
                    .transition(.scale)
            }
        }
    }
    
    @ViewBuilder
    private func newTypePrompt() -> some View{
        VStack{
            Text("Give a name for your training")
                .bold()
            TextField("Training name", text: $viewModel.newType)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .frame(width: 250)
            Button(action : {
                addType(viewModel.newType)
                viewModel.isPopUpDisplayed = false
            }){
                Text("Add")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .cornerRadius(10)
            }
        }
        .frame(width: 300, height: 250)
        .background(.background)
        .cornerRadius(20)
        .shadow(radius: 10)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
    
    private func addType(_ name : String){
        for group in muscleGroups{
            if group.name == "Other"{
                group.exerciseTypes.append(ExerciseType(type: name))
            }
        }
    }
}

#Preview {
    AddExerciseView(onNewExercise: {_ in })
}
