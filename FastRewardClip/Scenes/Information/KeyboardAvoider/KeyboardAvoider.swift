//
//  KeyboardAvoider.swift
//  FastRewardClip
//
//  Created by Asadbek Nematov on 7/4/24.
//

import SwiftUI
import Combine

struct KeyboardAvoider: ViewModifier {
    @State private var offset: CGFloat = 0
    @State private var keyboardHeight: CGFloat = 0
    private var keyboardPublisher = Publishers.Merge(
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { $0.keyboardHeight },
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
    ).eraseToAnyPublisher()

    func body(content: Content) -> some View {
        content
            .padding(.bottom, offset)
            .onReceive(keyboardPublisher) { height in
                offset = height
            }
            .animation(.easeOut(duration: 0.3), value: offset)
    }
}

extension View {
    func avoidKeyboard() -> some View {
        modifier(KeyboardAvoider())
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
