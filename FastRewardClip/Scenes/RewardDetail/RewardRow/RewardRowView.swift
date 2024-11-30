//
//  RewardRowView.swift
//  TaperkClip
//
//  Created by Asadbek Nematov on 7/4/24.
//

import SwiftUI

struct RewardRowView: View {
    var reward: Reward
    
    var body: some View {
        HStack {
            Image(reward.image)
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(10)
                .padding()
            
            VStack(alignment: .leading) {
                Text("Taperk's Kitchen")
                    .font(.headline)
                    .padding(.bottom, 2)
                
                Text(reward.name)
                    .font(.subheadline)
                
                Text("Claimable")
                    .font(.caption)
                    .foregroundColor(Color("territoryT"))
                    .padding(.top, 2)
            }
            Spacer()
        }
        .background(Color("secondaryT").opacity(0.1))
        .cornerRadius(10)
    }
}
