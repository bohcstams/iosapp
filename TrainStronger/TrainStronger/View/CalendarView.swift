//
//  CalenarView.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 29..
//

import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate : Date

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
            }
            .padding()
        }
        
        var formattedDate: String {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: selectedDate)
        }
}

struct CalendarView_Preview : PreviewProvider{
    @State static var date = Date()
    static var previews: some View {
        CalendarView(selectedDate: $date)
    }
}
