//
//  RewardView.swift
//  TaperkClip
//
//  Created by Asadbek Nematov on 6/13/24.
//
import SwiftUI

struct RewardView: View {
    let reward: Reward
    @Binding var totalPoints: Int
    @Binding var cart: [Reward]
    @State private var isSelected: Bool = false

    var body: some View {
        let isSelectable = totalPoints >= reward.pointsRequired || isSelected

        ZStack {
            Image(reward.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 166, height: 210)
                .clipped()
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isSelected ? Color.green : Color.clear, lineWidth: 3)
                )
                .grayscale(isSelectable || isSelected ? 0 : 1)
                .opacity(isSelectable || isSelected ? 1 : 0.5)

            VStack {
                HStack {
                    Image(systemName: isSelected ? "checkmark.circle.fill" : (isSelectable ? "circle" : "xmark.circle.fill"))
                        .foregroundColor(isSelected ? Color.green : (isSelectable ? Color.white : Color.red))
                        .padding()
                    Spacer()
                }
                Spacer()
                Text(reward.name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding([.leading, .trailing, .bottom])
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(1), Color.black.opacity(0)]), startPoint: .bottom, endPoint: .init(x: 0.5, y: 0.6))
                    .cornerRadius(20)
            )

            VStack {
                HStack {
                    Spacer()
                    HStack {
                        if totalPoints >= reward.pointsRequired {
                        Image("crown2")
                            .resizable()
                            .frame(width: 20, height: 20)
                    } else {
                        Image("crown1")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                        Text( "\(totalPoints)/6")
                            .foregroundColor(totalPoints >= reward.pointsRequired ? Color("territoryT") : Color("primaryT"))
                            .padding(0)
                    }
                    .padding(5)
                    .font(.system(size: 15))
                    .background(totalPoints >= reward.pointsRequired ? Color.white : Color("territoryT"))
                    .cornerRadius(20)
                    .padding()
                }
                Spacer()
            }
        }
        .frame(width: 166, height: 210)
        .padding()
        .onTapGesture {
            if isSelectable {
                isSelected.toggle()
                if isSelected {
                    addToCart(reward: reward)
                } else {
                    removeFromCart(reward: reward)
                }
            }
        }
    }

    private func addToCart(reward: Reward) {
        if totalPoints >= reward.pointsRequired {
            cart.append(reward)
            totalPoints -= reward.pointsRequired
        }
    }

    private func removeFromCart(reward: Reward) {
        if let index = cart.firstIndex(where: { $0.id == reward.id }) {
            cart.remove(at: index)
            totalPoints += reward.pointsRequired
        }
    }
}

struct RewardView_Previews: PreviewProvider {
    @State static var totalPoints = 10
    @State static var cart: [Reward] = []
    
    static var previews: some View {
        RewardView(reward: Reward(name: "$2 OFF", pointsRequired: 6, image: "reward1"), totalPoints: $totalPoints, cart: $cart)
    }
}
