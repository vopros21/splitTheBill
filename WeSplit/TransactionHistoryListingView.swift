//
//  TransactionHistoryListingView.swift
//  WeSplit
//
//  Created by Mike Kostenko on 23/06/2024.
//

import SwiftData
import SwiftUI

struct TransactionHistoryListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query var history: [HistoricalTransaction]
    
    let currencyID: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "EUR")
    
    var body: some View {
        List {
            ForEach(history) { transaction in
                NavigationLink {
                    TransactionView(transaction: transaction)
                } label: {
                    VStack(alignment: .leading) {
                        let amount = transaction.checkAmount * Double(1 + transaction.tipsPercentage / 100)
                        HStack {
                            Text("\(amount, format: currencyID)")
                                .font(.headline)
                            Spacer()
                            Label("\(transaction.people)", systemImage: "person.2")
                                .foregroundStyle(.secondary)
                        }
                        Text(transaction.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteTransaction)
        }
    }
    
    init(sort: SortDescriptor<HistoricalTransaction>) {
        
        _history = Query(sort: [sort])
    }
    
    func deleteTransaction(_ indexSet: IndexSet) {
        for index in indexSet {
            let transaction = history[index]
            modelContext.delete(transaction)
        }
    }
}

#Preview {
    TransactionHistoryListingView(sort: SortDescriptor(\HistoricalTransaction.date, order: .reverse))
}
