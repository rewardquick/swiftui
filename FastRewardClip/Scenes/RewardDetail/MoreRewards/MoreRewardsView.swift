//
//  MoreRewardsView.swift
//  TaperkClip
//
//  Created by Asadbek Nematov on 7/4/24.
//

import SwiftUI


struct MoreRewardsView: View {
    var rewards: [Reward]
    
    var body: some View {
        VStack {
            Text("Other rewards")
                .font(.custom("Futura", size: 24))
                .bold()
                .padding()
                .foregroundColor(Color("primaryT"))
                .frame(maxWidth: .infinity, alignment: .leading)

            ScrollView {
                VStack(spacing: 10) {
                    ForEach(rewards) { reward in
                        ZStack {
                            Image("box")
                            HStack {
                                Image(reward.image)
                                    .resizable()
                                    .frame(width: 65, height: 65)
                                    .cornerRadius(10)
                                    .padding(.leading, 5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("territoryT"), lineWidth: 2)
                                            .padding(.leading, 5)
                                    )
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width: 6, height: 30)
                                    .padding(.horizontal, 5)

                                VStack(alignment: .leading) {
                                    Spacer()
                                    Text("Vietnamese Restaurant")
                                        .font(.custom("Futura", size: 16))
                                        .foregroundColor(Color.white)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    Text(reward.name)
                                        .foregroundColor(Color.white)
                                        .font(.custom("Futura", size: 16))
                                        .fontWeight(.medium)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text("3/\(reward.pointsRequired)")
                                        .frame(width: 30, height: 20)
                                        .foregroundColor(Color.white)
                                        .font(.custom("Futura", size: 10))
                                        .fontWeight(.bold)
                                        .background(Color("territoryT"))
                                        .cornerRadius(50)
                                    
                                    Spacer()
                                }
                            }
                            .frame(width: 310)
                        }
                    }
                }
                
                Text("Comeback Vietnamese Restaurant for more!")
                    .font(.custom("Futura", size: 20))
                    .padding()
                    .foregroundColor(Color("primaryT"))
                    .frame(maxWidth: 350, alignment: .center)
                    .multilineTextAlignment(.center)
            }
        }
        .background(Color("backgroundT"))
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

struct MoreRewardsView_Previews: PreviewProvider {
    static var previews: some View {
        MoreRewardsView(rewards: [
            Reward(name: "Free Spring Rolls", pointsRequired: 3, image: "reward1"),
            Reward(name: "50% Off Rice Platter", pointsRequired: 4, image: "reward2"),
            Reward(name: "Free Banh Mi", pointsRequired: 5, image: "reward3")
        ])
    }
}
