//
//  SetView.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 29..
//

import SwiftUI

struct SetView: View {
    
    @State var numberOfSet: Int
    @State var repetitions: Int
    @State var weight: Double
    @State var showModal : Bool = false
    
    init(numberOfSet: Int, reps: Int, weight: Double){
        self.numberOfSet = numberOfSet
        self.repetitions = reps
        self.weight = weight
    }
    
    var body: some View {
        ZStack{
            HStack{
                Text("\(numberOfSet)")
                    .bold()
                    .padding()
                Spacer()
                Text("\(repetitions)")
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                    .onTapGesture {
                        withAnimation(.easeIn){
                            showModal = true
                        }
                    }
                Spacer()
                Text(formatDouble(weight))
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 2)
                    )
                    .onTapGesture {
                        withAnimation(.easeIn){
                            showModal = true
                        }
                    }
            }
            .padding()
            
            if showModal{
                Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.easeOut){
                        showModal = false
                    }
                }
                
                EditSetView(repetitions: $repetitions, weight: $weight)
                    .transition(.opacity)
            }
        }
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
    SetView(numberOfSet: 1, reps: 15, weight: 35)
}
