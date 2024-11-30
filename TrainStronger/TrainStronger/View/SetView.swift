//
//  SetView.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 29..
//

import SwiftUI

struct SetView: View {
    
    @State var repetitions: Double
    @State var weight: Double
    
    init(reps: Double, weight: Double){
        self.repetitions = reps
        self.weight = weight
    }
    
    var body: some View {
        HStack{
            IncDecTextView(width: 30, amount: 1, value: $repetitions)
                .padding(.trailing)
            IncDecTextView(width: 50, amount: 2.5, value: $weight)
        }
        .padding(.horizontal)
    }
    
    func formatDouble(_ value: Double) -> String {
            return String(format: "%g", value)
        }
}

struct EditSetView : View{
    @Binding var repetitions : Int
    @Binding var weight : Double
    
    var body: some View{
        VStack {
            Text("Edit set")
                .font(.headline)
                .padding()
            
            
            Text("Tap anywhere outside to close.")
                .padding(.bottom)
        }
        .frame(width: 250, height: 150)
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray, lineWidth: 1)
        )
        .onTapGesture {
        }
        
    }
}

#Preview {
    SetView(reps: 15, weight: 95)
}
