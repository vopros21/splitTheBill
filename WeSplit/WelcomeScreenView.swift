//
//  WelcomeScreenView.swift
//  WeSplit
//
//  Created by Mike Kostenko on 10/08/2024.
//

import SwiftUI

struct WelcomeScreenView: View {
    @AppStorage("welcomeScreenShown")
    private var welcomeScreenShown = false
    
    var body: some View {
        VStack {
            Text("Split your bill")
                .font(.largeTitle).bold()
                .padding(.bottom)
            Group{
                Text("1. Add tips")
                Image(systemName: "arrow.down")
                Text("2. Pay for all at once")
                Image(systemName: "arrow.down")
                Text("3. Get payment back later")
            }
            .padding(.bottom, 10)
            .frame(minWidth: 200, alignment: .center)
            
            Spacer()
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            Button {
                welcomeScreenShown.toggle()
            } label: {
                Text("Continue")
                    .font(.title3)
                    .tint(.primary)
            }
            .padding()
            .background(.grayBluewishControl)
            .clipShape(Capsule())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.grayBluewishBg)
    }
}

#Preview {
    WelcomeScreenView()
}
