//
//  ContentView.swift
//  TaperkClip
//
//  Created by Asadbek Nematov on 6/10/24.
//
import SwiftUI

struct ContentView: View {
    @Binding var incomingURL: URL?

    var body: some View {
        ZStack {
            Color.backgroundT
                .ignoresSafeArea()
            ListRewards()
                .onAppear {
                    if let url = incomingURL {
                        handleIncomingURL(url: url)
                    }
                }
        }
    }

    private func handleIncomingURL(url: URL) {
        // Handle the URL here
        print("Received URL: \(url)")
        // Implement your navigation logic based on the URL
    }
}

struct ContentView_Previews: PreviewProvider {
    @State static var incomingURL: URL?

    static var previews: some View {
        ContentView(incomingURL: $incomingURL)
    }
}
