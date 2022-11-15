//
//  ContentView.swift
//  TextFieldFocusBinding
//
//  Created by Karsten Silkenbäumer on 15.11.22.
//

import SwiftUI

struct FocusedPointBinding: FocusedValueKey {
    typealias Value = Binding<Int>
}

extension FocusedValues {
    var pointBinding: FocusedPointBinding.Value? {
        get { self[FocusedPointBinding.self] }
        set { self[FocusedPointBinding.self] = newValue }
    }
}

struct PointButton: View {
    @FocusedBinding(\.pointBinding) var value // Workaround instead of: var value
    let diff: Int

    var body: some View {
        Button("\(diff > 0 ? "+" : "")\(diff)") {
            if diff > 0 {
                value = (value ?? 0) + diff
            } else {
                value = max(0, (value ?? 0) + diff)
            }
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .padding(.horizontal, 2)
    }
}

struct ContentView: View {
    @State private var points: Int = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Value is \(points)")
            
            TextField("Enter value", value: $points, format: .number)
                .focusedValue(\.pointBinding, $points)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                PointButton(diff: -10)
                PointButton(diff: -1)
                PointButton(diff: +1)
                PointButton(diff: +10)
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
