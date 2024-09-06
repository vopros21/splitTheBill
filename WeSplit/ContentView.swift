//
//  ContentView.swift
//  WeSplit
//
//  Created by Mike Kostenko on 20/08/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @AppStorage("welcomeScreenShown")
    private var welcomeScreenShown = false
    @AppStorage("paidUser")
    private var isPaidUser = false
    
    @State private var sortOrder = SortDescriptor(\HistoricalTransaction.date, order: .reverse)
    
    @State private var showingAlert = false
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 5
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 5, 10, 15, 20, 25]
    let currencyID: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "EUR")
    
    var totalPerPerson: Double {
        return totalAmount / Double(numberOfPeople + 2)
    }
    
    var totalAmount: Double {
        return checkAmount + checkAmount / 100 * Double(tipPercentage)
    }
    
    var body: some View {
        if welcomeScreenShown {
            NavigationStack {
                Form {
                    Section("Bill Amount") {
                        TextField("Amount", value: $checkAmount, format: currencyID)
                            .font(.title3)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                            .onAppear {
                                UITextField.appearance().clearButtonMode = .whileEditing
                            }
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Button {
                                        amountIsFocused.toggle()
                                    } label: {
                                        Image(systemName: "keyboard.chevron.compact.down")
                                    }
                                    Spacer()
                                    Button {
                                        saveTransaction()
                                        amountIsFocused.toggle()
                                    } label: {
                                        Image(systemName: "square.and.arrow.down")
                                    }
                                    .disabled(checkAmount == 0)
                                }
                            }
                        Stepper("People: \(numberOfPeople + 2)", value: $numberOfPeople, in: 0...28)
                            .font(.title3)
                    }
                    .listRowBackground(Color.clear)
                    
                    Section("Tips to leave:") {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self){
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                        .colorMultiply(Color(.grayBluewishControl))
                    }
                    .listRowBackground(Color.clear)
                    
                    Section {
                        HStack {
                            Text("Amount per person:")
                            Spacer()
                            Text(totalPerPerson, format: currencyID)
                                .font(.title)
                                .bold()
                        }
                        HStack {
                            Text("Total with tips:")
                            Spacer()
                            Text(totalAmount, format: currencyID)
                                .font(.title3)
                                .bold()
                        }
                    } header: {
                        Text("To pay:")
                    }
                    .listRowBackground(Color.clear)
                    .monospacedDigit()
                    
                    if isPaidUser {
                        TransactionHistoryListingView(sort: sortOrder)
                    } else {
                        BehindPaywallView()
                    }
                }
                .scrollContentBackground(.hidden) // will hide default background for scroll content
                //            .background(Gradient(colors: [.orange.opacity(0.5), .yellow.opacity(0.5), .green.opacity(0.8)]))
                .background(Gradient(colors: [Color(.grayBluewishBg).opacity(0.5),
                                              .clear.opacity(0.5)]))
                .navigationTitle("Split the bill")
                .toolbar {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Label("Date", systemImage: "calendar").tag(SortDescriptor(\HistoricalTransaction.date, order: .reverse))
                            Label("Amount", systemImage: "arrowtriangle.up.fill").tag(SortDescriptor(\HistoricalTransaction.checkAmount))
                            Label("Amount", systemImage: "arrowtriangle.down.fill").tag(SortDescriptor(\HistoricalTransaction.checkAmount, order: .reverse))
                        }
                        .pickerStyle(.inline)
                        .foregroundStyle(.black)
                    }
                    if checkAmount != 0 {
                        Button("Done") {
                            saveTransaction()
                            amountIsFocused = false
                        }
                    }
                }
                .toolbarBackground(Color(.grayBluewishTb).opacity(0.5))
                .alert("\(totalPerPerson, format: currencyID)", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("""
                            per person
                            Total amount: \(totalAmount, format: currencyID)
                        """)
                        .font(.title)
                }
            }
            .tint(.primary)
        } else {
            WelcomeScreenView()
        }
    }
    
    func saveTransaction() {
        // TODO: add precondition for an empty transaction from https://www.hackingwithswift.com/plus/inside-swift/the-power-of-preconditions ts: 11:20
        let transaction = HistoricalTransaction(contacts: [], people: numberOfPeople + 2, checkAmount: checkAmount, tipsPercentage: tipPercentage)
        modelContext.insert(transaction)
        if !isPaidUser {
            showingAlert = true
        } else {
            checkAmount = 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
