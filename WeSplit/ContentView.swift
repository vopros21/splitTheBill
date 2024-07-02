//
//  ContentView.swift
//  WeSplit
//
//  Created by Mike Kostenko on 20/08/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var sortOrder = SortDescriptor(\HistoricalTransaction.date, order: .reverse)
    
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
                TransactionHistoryListingView(sort: sortOrder)
            }
            .scrollContentBackground(.hidden) // will hide default background for scroll content
            .background(Gradient(colors: [.orange.opacity(0.5), .yellow.opacity(0.5), .green.opacity(0.8)]))
            .navigationTitle("Split the bill")
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Label("Date", systemImage: "calendar").tag(SortDescriptor(\HistoricalTransaction.date, order: .reverse))
                        Label("Amount", systemImage: "arrowtriangle.up.fill").tag(SortDescriptor(\HistoricalTransaction.checkAmount))
                        Label("Amount", systemImage: "arrowtriangle.down.fill").tag(SortDescriptor(\HistoricalTransaction.checkAmount, order: .reverse))
                    }
                    .pickerStyle(.inline)
                }
                if amountIsFocused {
                    Button("Done") {
                        saveTransaction()
                        amountIsFocused.toggle()
                    }
                }
            }
            .toolbarBackground(.orange.opacity(0.5))
        }
    }
    
    func saveTransaction() {
        // TODO: add precondition for an empty transaction from https://www.hackingwithswift.com/plus/inside-swift/the-power-of-preconditions ts: 11:20
        let transaction = HistoricalTransaction(contacts: [], people: numberOfPeople + 2, checkAmount: checkAmount, tipsPercentage: tipPercentage)
        modelContext.insert(transaction)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
