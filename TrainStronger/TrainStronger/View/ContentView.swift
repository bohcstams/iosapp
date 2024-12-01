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
    @Query private var items: [Item]
    @Query private var trainings: [Training]
    @ObservedObject var viewModel = TrainingsViewModel()
    @State var deepLink: String?
    
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
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
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
                    NavigationLink{
                        TrainingView(onFinish: viewModel.addTraining, date: viewModel.date)
                    } label : {
                        Text("Start new training")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal)
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

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
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
