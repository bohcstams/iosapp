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
    @State var date : Date = Date()
    @State var trainings : [Training] = []
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
    
    var filteredTrainings : [Training] {
        var filteredTrainings : [Training] = []
        for training in trainings{
            if training.date == date{
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
            VStack{
                CalendarView(selectedDate: $date)
                NavigationLink{
                    TrainingView(onFinish: addTraining, date: date)
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
                List(filteredTrainings){ training in
                    VStack{
                        Text("\(training.name)")
                        Divider()
                        Text("Number of exercises: \(training.exercises.count)")
                            .font(.caption)
                    }
                }
                .listStyle(.sidebar)
            }
        }
        
    }
    
    private func addTraining(_ training : Training){
        trainings.append(training)
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
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
