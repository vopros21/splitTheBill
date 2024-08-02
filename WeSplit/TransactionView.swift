//
//  TransactionView.swift
//  WeSplit
//
//  Created by Mike Kostenko on 30/07/2024.
//

import SwiftUI

struct TransactionView: View {
    @State var transaction: HistoricalTransaction
    let currencyID: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "EUR")
    @FocusState private var commentIsFocused: Bool
    
    var amount: Double {
        transaction.checkAmount * Double(1 + transaction.tipsPercentage / 100)
    }
    
    var paid: Double {
        amount / Double(transaction.people)
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("Total amount:")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(transaction.checkAmount, format: currencyID)")
                    .font(.title3.bold())
            }
            HStack {
                Text("Tips:")
                    .foregroundStyle(.secondary)
                Spacer()
                Text("\(transaction.tipsPercentage)%")
                    .font(.title3).bold()
            }
            Spacer()
                .frame(height: 10)
            Group{
                HStack{
                    Text("Comment:").foregroundStyle(.secondary)
                    Spacer()
                }
                TextField("Type comment", text: $transaction.comment, axis: .vertical)
                    .padding(4)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.grayBluewishControl).opacity(0.2))
                    .focused($commentIsFocused)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button {
                                commentIsFocused.toggle()
                            } label: {
                                Image(systemName: "keyboard.chevron.compact.down")
                            }
                        }
                    }
            }
                
            Spacer()
        }
        .padding()
        .background(Gradient(colors: [Color(.grayBluewishBg).opacity(0.5), .clear.opacity(0.5)]))
        .navigationTitle("\(transaction.date.formatted(.dateTime.year(.twoDigits).month(.abbreviated).day(.defaultDigits))): \(paid, format: currencyID)")
    }
}

//#Preview {
//    TransactionView(transaction: HistoricalTransaction(contacts: [], people: 3, checkAmount: 32.12, tipsPercentage: 10))
//}
