//
//  IncDecTextView.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 30..
//

import SwiftUI

struct IncDecTextView<T: Numeric & Comparable>: View {
    let width : CGFloat
    let amount: T
    let editable: Bool
    @Binding var value : T
    
    var body: some View {
        HStack{
            if editable{
                Button(action: {
                    if value > 0{
                        value -= amount
                    }
                }) {
                    Image(systemName: "minus")
                        .foregroundColor(.gray)
                        .font(.system(size: 30))
                }
            }
            Text(formatValue(value))
                .frame(width: width, height: 10)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
            )
            if editable{
                Button(action: {
                    value += amount
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.gray)
                        .font(.system(size: 30))
                }
            }
        }
    }
    
    func formatValue(_ value: T) -> String {
            if let intValue = value as? Int {
                return "\(intValue)"
            } else if let doubleValue = value as? Double {
                return String(format: "%g", doubleValue)
            }
            return "\(value)"
        }
}

struct IncrementDecrementView_Previews: PreviewProvider {
    @State static var previewValue: Double = 5.0
    static var previews: some View {
        IncDecTextView(width: 40, amount: 1, editable: false, value: $previewValue)
    }
}
