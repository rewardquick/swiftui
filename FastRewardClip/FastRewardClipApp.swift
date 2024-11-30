//
//  TaperkClipApp.swift
//  TaperkClip
//
//  Created by Asadbek Nematov on 6/10/24.
//

import SwiftUI

@main
struct FastRewardClipApp: App {
    @State private var incomingURL: URL?

    var body: some Scene {
        WindowGroup {
            ContentView(incomingURL: $incomingURL)
                .onOpenURL { url in
                    incomingURL = url
                }
        }
    }
}
