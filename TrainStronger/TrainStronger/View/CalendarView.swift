//
//  CalenarView.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 29..
//

import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()

        var body: some View {
            VStack{
                Text("Select a Date")
                    .font(.headline)
                
                DatePicker(
                    "Select a date",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()
                
                Text("Selected date: \(formattedDate)")
                    .padding()
            }
            .padding()
            Spacer()
        }
        
        var formattedDate: String {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: selectedDate)
        }
}

#Preview {
    CalendarView()
}
