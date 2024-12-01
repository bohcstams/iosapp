//
//  ContentView.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 29..
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
    @Query private var trainings: [Training]
    @ObservedObject var viewModel = TrainingsViewModel()
    @State var deepLink: String?
    @State private var isActive = false
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: viewModel.date)
    }
    
    var filteredTrainings : [Training] {
        var filteredTrainings : [Training] = []
        for training in trainings{
            if areDatesEqual(training.date, viewModel.date){
                filteredTrainings.append(training)
            }
        }
        return filteredTrainings
    }

    var body: some View {
        NavigationStack{
            TabView{
                VStack{
                    CalendarView(selectedDate: $viewModel.date)
                    NavigationLink(destination: TrainingView(onFinish: viewModel.addTraining, date: viewModel.date),isActive: Binding(
                        get: { deepLink == "newtraining" },
                        set: { if !$0 { deepLink = nil } }
                    )){
                        EmptyView()
                    }
                    Button(action: {
                        triggerHapticFeedback()
                        self.isActive = true
                    }) {
                        Text("Start new training")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                    NavigationLink(
                        destination: TrainingView(onFinish: viewModel.addTraining, date: viewModel.date),
                        isActive: $isActive
                    ) {
                        EmptyView()
                    }
                    Text("Trainings on \(formattedDate):")
                        .font(.title3)
                        .padding(.top)
                    List{
                        ForEach(filteredTrainings){ training in
                            NavigationLink{
                                TrainingView(for: training)
                            } label: {
                                VStack(alignment: .leading){
                                    Text("\(training.name)")
                                    Text("Number of exercises: \(training.exercises.count)")
                                        .font(.caption)
                                }
                            }
                        }
                        .onDelete(perform: deleteTraining)
                    }
                    .listStyle(.sidebar)
                }
                .tabItem {
                    Label("List", systemImage: "chart.bar.doc.horizontal.fill")
                }
                
                MapTabView()
                    .tabItem {
                        Label("Map", systemImage: "map.fill")
                    }
                    .environmentObject(viewModel)
            }
        }
        .onOpenURL { url in
            deepLink = url.host
        }
        
    }
    
    private func deleteTraining(offsets: IndexSet){
        withAnimation{
            for index in offsets{
                viewModel.deleteTraining(filteredTrainings[index])
            }
        }
    }
    
    private func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }
    
    private func areDatesEqual(_ date1: Date, _ date2: Date) -> Bool {
        let calendar = Calendar.current
        
        let components1 = calendar.dateComponents([.year, .month, .day], from: date1)
        let components2 = calendar.dateComponents([.year, .month, .day], from: date2)
        
        return components1.year == components2.year &&
               components1.month == components2.month &&
               components1.day == components2.day
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
