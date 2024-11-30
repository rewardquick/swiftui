//
//  PhoneNumberTextFieldView.swift
//  FastRewardClip
//
//  Created by Asadbek Nematov on 7/4/24.
//

import SwiftUI
import PhoneNumberKit

struct PhoneNumberTextFieldView: UIViewRepresentable {
    @Binding var phoneNumber: String
    let phoneNumberKit = PhoneNumberKit()

    func makeUIView(context: Context) -> PhoneNumberTextField {
        let textField = PhoneNumberTextField(withPhoneNumberKit: phoneNumberKit)
        textField.withExamplePlaceholder = true
        textField.withDefaultPickerUI = true
        textField.withFlag = true // Enable country flag display
        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [.font: UIFont(name: "Futura-Medium", size: 25) ?? UIFont.systemFont(ofSize: 25)]
        )
        textField.defaultTextAttributes = [
            .font: UIFont(name: "Futura-Medium", size: 25) ?? UIFont.systemFont(ofSize: 25)
        ]
        textField.textAlignment = .center // Center the text inside the text field

        textField.addTarget(context.coordinator, action: #selector(Coordinator.textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }

    func updateUIView(_ uiView: PhoneNumberTextField, context: Context) {
        uiView.text = phoneNumber
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: PhoneNumberTextFieldView

        init(_ parent: PhoneNumberTextFieldView) {
            self.parent = parent
        }

        @objc func textFieldDidChange(_ textField: UITextField) {
            if let text = textField.text {
                parent.phoneNumber = text
            }
        }
    }
}

