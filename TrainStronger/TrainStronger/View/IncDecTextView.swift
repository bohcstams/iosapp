//
//  IncDecTextView.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 30..
//

import SwiftUI

struct IncDecTextView: View {
    let width : CGFloat
    let amount: Double
    @Binding var value : Double
    
    var body: some View {
        HStack{
            Button(action: {
                if value > 0{
                    value -= amount
                }
            }) {
                Image(systemName: "minus")
                    .foregroundColor(.gray)
                    .font(.system(size: 30))
            }
            Text(formatDouble(value))
                .frame(width: width, height: 10)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
            )
            Button(action: {
                value += amount
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.gray)
                    .font(.system(size: 30))
            }
        }
    }
    
    func formatDouble(_ value: Double) -> String {
            return String(format: "%g", value)
        }
}

struct IncrementDecrementView_Previews: PreviewProvider {
    @State static var previewValue: Double = 5.0
    static var previews: some View {
        IncDecTextView(width: 40, amount: 1, value: $previewValue)
    }
}
