//
//  CartView.swift
//  TaperkClip
//
//  Created by Asadbek Nematov on 6/13/24.
//

import SwiftUI

struct CartView: View {
    @Binding var cart: [Reward]
    @Binding var totalPoints: Int
    @Environment(\.presentationMode) var presentationMode

    // Computed property to get the total points of items in the cart
    private var totalPointsInCart: Int {
        cart.map { $0.pointsRequired }.reduce(0, +)
    }

    var body: some View {
        VStack {
            HStack {
                Text("Vietnamese Restaurant")
                    .font(.custom("Futura", size: 24))
                    .bold()
                    .padding()
                    .foregroundColor(Color("primaryT"))
                Spacer()
            }

            if cart.isEmpty {
                emptyCartView
            } else {
                filledCartView
            }
        }
        .navigationBarColor(UIColor(named: "blankT"), titleColor: UIColor(named:"territoryT"))
        .background(Color("backgroundT").ignoresSafeArea())
        .navigationBarTitle("Cart", displayMode: .automatic)
    }

    private var emptyCartView: some View {
        VStack {
            Text("Your cart is empty")
                .font(.custom("Futura", size: 24))
                .foregroundColor(.gray)
                .padding(.top, 50)
            Spacer()
            NavigationLink(destination: FinalPageView()) {
                Text("Done")
                    .font(.title2)
                    .padding()
                    .frame(width: 250, height: 50)
                    .background(Color("primaryT"))
                    .foregroundColor(.white)
                    .cornerRadius(50)
            }
            .padding(.bottom, 30)
        }
    }

    private var filledCartView: some View {
        VStack {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(cart) { reward in
                        rewardRow(reward)
                    }
                }
                .padding()
            }
            rewardDetails
            actionButtons
        }
    }

    private func rewardRow(_ reward: Reward) -> some View {
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
                    Text(reward.name)
                        .foregroundColor(Color.white)
                        .font(.custom("Futura", size: 16))
                        .fontWeight(.medium)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Size: Regular")
                        .foregroundColor(Color.white)
                        .font(.custom("Futura", size: 12))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Qty: 1")
                        .foregroundColor(Color.white)
                        .font(.custom("Futura", size: 12))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(reward.pointsRequired) points")
                        .foregroundColor(Color.white)
                        .font(.custom("Futura", size: 10))
                        .frame(width: 50, height: 20, alignment: .center)
                        .fontWeight(.bold)
                        .background(Color("territoryT"))
                        .cornerRadius(50)
                    Spacer()
                }
                Spacer()
                Button(action: {
                    removeFromCart(reward: reward)
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(Color.red)
                        .padding()
                }
            }
            .frame(width: 300)
        }
    }

    private var rewardDetails: some View {
        VStack {
            HStack {
                Text("Reward Details")
                    .font(.custom("Futura-Bold", size: 20))
                    .padding(.bottom, 5)
                    .padding(.horizontal)
                    .foregroundColor(Color("primaryT"))
                Spacer()
            }

            HStack {
                Text("Quantity")
                    .font(.custom("Futura", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.bottom, 0)
                Spacer()
                Text("\(cart.count) Rewards")
                    .font(.custom("Futura", size: 16))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.bottom, 0)
            }
            HStack {
                Text("Order Total")
                    .font(.custom("Futura", size: 20))
                    .padding(.bottom, 5)
                    .padding(.horizontal)
                    .foregroundColor(Color("primaryT"))
                    .padding(.bottom, 0)
                Spacer()
                Text("\(totalPointsInCart) points")
                    .font(.custom("Futura", size: 20))
                    .padding(.bottom, 5)
                    .padding(.horizontal)
                    .padding(.bottom, 0)
                    .foregroundColor(Color("primaryT"))
            }.padding(.bottom, 40)
        }
    }

    private var actionButtons: some View {
        VStack {
            Button(action: {
                cart.removeAll()
                // Assume points are refunded for simplicity
                totalPoints += totalPointsInCart
            }) {
                Text("Clear Cart")
                    .font(.title2)
                    .padding()
                    .frame(width: 250, height: 50)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(50)
            }

            NavigationLink(destination: InformationView(selectedRewards: $cart)) {
                Text("Confirm")
                    .font(.title2)
                    .padding()
                    .frame(width: 250, height: 50)
                    .background(Color("primaryT"))
                    .foregroundColor(.white)
                    .cornerRadius(50)
            }
            .padding(.bottom, 10)
        }
    }

    private func removeFromCart(reward: Reward) {
        if let index = cart.firstIndex(where: { $0.id == reward.id }) {
            cart.remove(at: index)
            totalPoints += reward.pointsRequired
        }
    }
}

struct CartView_Previews: PreviewProvider {
    @State static var cart: [Reward] = [
        Reward(name: "$2 OFF", pointsRequired: 6, image: "reward5"),
        Reward(name: "$2 OFF", pointsRequired: 9, image: "reward1"),
        Reward(name: "$2 OFF", pointsRequired: 8, image: "reward2")
    ]
    @State static var totalPoints: Int = 14

    static var previews: some View {
        CartView(cart: $cart, totalPoints: $totalPoints)
    }
}
