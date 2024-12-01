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
    @State private var textValue: String = "0"
    
    var body: some View {
        HStack{
            if editable{
                Button(action: {
                    if value > 0{
                        value -= amount
                        updateTextValue()
                    }
                }) {
                    Image(systemName: "minus")
                        .foregroundColor(.gray)
                        .font(.system(size: 30))
                }
            }
            TextField("0", text: $textValue)
                .onChange(of: textValue) { newValue in
                    if let newValue = convertToNumeric(newValue) {
                        value = newValue
                    }
                }
                .frame(width: width, height: 10)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 2)
                )
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.center)
                .onAppear {
                    updateTextValue()
                }
                .disabled(!editable)
            if editable{
                Button(action: {
                    value += amount
                    updateTextValue()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.gray)
                        .font(.system(size: 30))
                }
            }
        }
    }
    
   func updateTextValue() {
       textValue = formatValue(value)
   }
   
   func formatValue(_ value: T) -> String {
       if let intValue = value as? Int {
           return "\(intValue)"
       } else if let doubleValue = value as? Double {
           return String(format: "%g", doubleValue)
       }
       return "\(value)"
   }
   
   func convertToNumeric(_ text: String) -> T? {
       if T.self == Int.self {
           return Int(text) as? T
       } else if T.self == Double.self {
           return Double(text) as? T
       }
       return nil
   }
}

struct IncrementDecrementView_Previews: PreviewProvider {
    @State static var previewValue: Double = 5.0
    static var previews: some View {
        IncDecTextView(width: 40, amount: 1, editable: true, value: $previewValue)
        IncDecTextView(width: 40, amount: 1, editable: false, value: $previewValue)
    }
}
