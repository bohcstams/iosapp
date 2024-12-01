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
            Training.self
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
        }
        .modelContainer(sharedModelContainer)
        .onChange(of: scenePhase) { oldState, newState in
            if newState == .active {
                TrainingManarger.shared.modelContainer = sharedModelContainer
            }
        }
    }
}
