//
//  SeeMoreRewardsView.swift
//  TaperkClip
//
//  Created by Asadbek Nematov on 6/14/24.
//
import SwiftUI

struct SeeMoreRewardsView: View {
    var rewards: [Reward]
    
    var body: some View {
        VStack {
            Text("Comeback Taperk's Kitchen to get more!")
                .font(.headline)
                .padding()

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(rewards) { reward in
                        HStack {
                            Image(reward.image)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("territoryT"), lineWidth: 2)
                                )
                                .padding()

                            VStack(alignment: .leading) {
                                Text("Taperk's Kitchen")
                                    .font(.headline)
                                    .foregroundColor(Color("primaryT"))
                                Text(reward.name)
                                    .foregroundColor(Color("secondaryT"))
                            }
                            Spacer()
                            Text("Claimable")
                                .font(.caption)
                                .foregroundColor(Color("territoryT"))
                                .padding(5)
                                .background(Color.yellow)
                                .cornerRadius(5)
                        }
                        .background(Color("secondaryT").opacity(0.1))
                        .cornerRadius(10)
                    }
                }
                .padding()
            }
        }
    }
}

