//
//  TrainStrongerApp.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 29..
//

import SwiftUI
import SwiftData

@main
struct TrainStrongerApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            Set.self,
            Exercise.self,
            Training.self,
            MuscleGroup.self,
            ExerciseType.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    @Environment(\.scenePhase) var scenePhase
    @State private var deepLink: String?

    var body: some Scene {
        WindowGroup {
            ContentView()
            .onOpenURL { url in
                deepLink = url.host
            }
            .onAppear{
                insertInitialData()
            }
        }
        .modelContainer(sharedModelContainer)
        .onChange(of: scenePhase) { oldState, newState in
            if newState == .active {
                TrainingManager.shared.modelContainer = sharedModelContainer
            }
        }
    }
    
    private func insertInitialData(){
        let context = sharedModelContainer.mainContext
                
        if UserDefaults.standard.bool(forKey: "initialDataInserted") == false {
            
            if let url = Bundle.main.url(forResource: "InitialExercises", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let muscleGroups = try JSONDecoder().decode([MuscleGroupDTO].self, from: data)
                    for group in muscleGroups {
                        context.insert(MuscleGroup(name : group.name, types: group.exerciseTypes))
                    }
                    UserDefaults.standard.set(true, forKey: "initialDataInserted")
                } catch {
                    print("Failed to load or insert initial data: \(error)")
                }
            }
        }
    }
}
