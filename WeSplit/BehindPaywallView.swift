//
//  BehindPaywallView.swift
//  WeSplit
//
//  Created by Mike Kostenko on 17/08/2024.
//

import SwiftUI

struct BehindPaywallView: View {
    @AppStorage("paidUser")
    private var isPaidUser = false
    
    var body: some View {
        HStack{
            Spacer()
            VStack {
                Text("See history payments")
                    .font(.title)
                Button{
                    isPaidUser.toggle()
                } label: {
                    Image(systemName: "text.badge.checkmark")
                    Text("Accept conditions")
                }
                .buttonStyle(.bordered)
            }
            Spacer()
        }
    }
}

#Preview {
    BehindPaywallView()
}
