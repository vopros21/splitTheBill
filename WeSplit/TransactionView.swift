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
    
    var amount: Double {
        transaction.checkAmount * Double(1 + transaction.tipsPercentage / 100)
    }
    
    var body: some View {
        VStack{
            Text("Total amount: \(transaction.checkAmount, format: currencyID)")
            Text("Tips: \(transaction.tipsPercentage)%")
            TextField("Comment", text: $transaction.comment)
                .padding()
            Spacer()
        }
        .navigationTitle("\(transaction.date.formatted(date: .long, time: .omitted))")
    }
}

//#Preview {
//    TransactionView(transaction: HistoricalTransaction(contacts: [], people: 3, checkAmount: 32.12, tipsPercentage: 10))
//}
