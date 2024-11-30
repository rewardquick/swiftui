//
//  GenderButton.swift
//  FastRewardClip
//
//  Created by Asadbek Nematov on 7/4/24.
//

import SwiftUI

struct GenderButton: View {
    var gender: String
    var icon: String?
    var selectedIcon: String?
    @Binding var selectedGender: String
    
    var body: some View {
        Button(action: {
            selectedGender = gender
        }) {
            HStack {
                if let icon = icon, let selectedIcon = selectedIcon {
                    Image(selectedGender == gender ? selectedIcon : icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
                Text(gender)
            }
            .font(.custom("Futura-Medium", size: 20))
            .padding()
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(selectedGender == gender ? (gender == "Male" ? Color.blue : gender == "Female" ? Color.pink : Color("secondaryT")) : Color.white)
            .foregroundColor(selectedGender == gender ? .white : Color("primaryT"))
            .cornerRadius(30)
            .shadow(radius: 5)
        }
    }
}
