//
//  SwiftUIView.swift
//  TaperkClip
//
//  Created by Asadbek Nematov on 7/4/24.
//
import SwiftUI



struct RewardDetailItemView: View {
    var reward: Reward
    
    var body: some View {
        VStack {
            ZStack{
                
           
            Image(reward.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 320, height: 320)
                .clipped()
                .cornerRadius(25)
                VStack {
                    Spacer()
                    Text("Vietnamese Restaurant")
                        .font(.custom("Futura", size: 24))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text(reward.name)
                        .font(.custom("Futura", size: 24))
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)
                }
                .frame(width: 320, height: 320)
                .background(
                    LinearGradient(gradient: Gradient(colors: [Color.black.opacity(1), Color.black.opacity(0)]), startPoint: .bottom, endPoint: .init(x: 0.5, y: 0.6))
                        .cornerRadius(25)
                )
            }
            .frame(width: 320, height: 320)
            
            
            Text("Redeem now?")
                .font(.headline)
                .padding(.bottom, 5)
            
            
            Text("Rewards do not expire until redeemed. Once redeemed, they expire in 15 minutes.")
                .frame(width: 320)
                .font(.caption)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal)
                .padding(.bottom, 0)
        }
//        .background(Color("backgroundT"))
        .cornerRadius(20)
//        .shadow(radius: 5)
        .padding(.top, 20)
        .padding(.bottom, 0)
    }
}

struct RewardDetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        RewardDetailItemView(reward: Reward(name: "Free Coffee", pointsRequired: 3, image: "reward4"))
    }
}
