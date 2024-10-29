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
    private let textPoints = [
        Feature(title: "Add tips", description: "Choose amount of tips you want to add", image: "1.circle"),
        Feature(title: "Pay for all at once", description: "Make one payment here and split it when you can", image: "2.circle"),
        Feature(title: "Get payment back", description: "Share payment with friends and get your money back", image: "3.circle")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Split your bill")
                        .multilineTextAlignment(.center)
                        .font(.largeTitle.bold())
                    ForEach(textPoints) { feature in
                        HStack {
                            Image(systemName: feature.image)
                                .frame(width: 44)
                                .font(.title)
                                .accessibilityHidden(true)
                            VStack(alignment: .leading) {
                                Text(feature.title)
                                    .font(.headline)
                                Text(feature.description)
                                    .foregroundStyle(.secondary)
                            }
                            .accessibilityElement(children: .combine)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
            }
            .padding()
            
            Button {
                close()
            } label: {
                Text("Continue")
                    .font(.title3)
                    .tint(.black)
            }
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(.grayBluewishControl)
            .cornerRadius(10)
            .padding()
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.grayBluewishBg)
    }
    
    func close() {
        welcomeScreenShown.toggle()
    }
}

#Preview {
    WelcomeScreenView()
}
