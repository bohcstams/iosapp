//
//  SetView.swift
//  TrainStronger
//
//  Created by Tamás Bohács on 2024. 11. 29..
//

import SwiftUI

struct SetView: View {
    
    @Bindable var set : Set
    let editable : Bool
    
    init(set : Set, editable : Bool){
        self.set = set
        self.editable = editable
    }
    
    var body: some View {
        HStack{
            IncDecTextView(width: 30, amount: 1, editable: editable, value: $set.repetitions)
                .padding(.trailing)
            IncDecTextView(width: 50, amount: 2.5, editable: editable, value: $set.weight)
        }
        .padding(.horizontal)
    }
}

#Preview {
    SetView(set: Set(weight: 0, reps: 0), editable: true)
}
