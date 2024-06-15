//
//  ContentView.swift
//  WeSplit
//
//  Created by Mike Kostenko on 20/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 5
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 5, 10, 15, 20, 25]
    let currencyID: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "EUR")
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        return checkAmount + checkAmount / 100 * Double(tipPercentage)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Bill Amount") {
                    TextField("Amount", value: $checkAmount, format: currencyID)
                        .font(.title3)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<21) {
                            Text("\($0) people")
                        }
                    }
                }
                .listRowBackground(Color.clear)
                
                Section("Tips to leave:") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    .colorMultiply(.orange)
                }
                .listRowBackground(Color.clear)
                
                Section {
                    HStack {
                        Spacer()
                        Text(totalPerPerson, format: currencyID)
                            .font(.title)
                            .bold()
                    }
                } header: {
                    Text("Amount per person:")
                }
                .listRowBackground(Color.clear)
                
                Section {
                    Text(totalAmount, format: currencyID)
                        .font(.title3)
                } header: {
                    Text("Total including tips")
                }
                .listRowBackground(Color.clear)
            }
            .scrollContentBackground(.hidden) // will hide default background for scroll content
            .background(Gradient(colors: [.orange.opacity(0.5), .yellow.opacity(0.5), .green.opacity(0.8)]))
            .navigationTitle("Split the bill")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused.toggle()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
