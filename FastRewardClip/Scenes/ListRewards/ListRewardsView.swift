//
//  ListRewardsView.swift
//  TaperkClip
//
//  Created by Asadbek Nematov on 6/12/24.
//

import SwiftUI

struct ListRewards: View {
    @State private var totalPoints: Int = 18 // Example total points
    @State private var earnedPoints: Int = 3 // Example earned points
    @State private var rewards: [Reward] = [
        Reward(name: "$2 OFF", pointsRequired: 6, image: "reward1"),
        Reward(name: "Green Tea", pointsRequired: 6, image: "reward2"),
        Reward(name: "Free Chips", pointsRequired: 6, image: "reward5"),
        Reward(name: "Free Coffee", pointsRequired: 6, image: "reward4"),
        Reward(name: "$2 OFF", pointsRequired: 6, image: "reward3"),
        Reward(name: "Green Tea", pointsRequired: 6, image: "reward5"),
        Reward(name: "Free Chips", pointsRequired: 6, image: "reward2"),
        Reward(name: "Free Coffee", pointsRequired: 6, image: "reward1")
    ]
    @State private var cart: [Reward] = []
    @State private var showTopShadow = false
    @State private var showBottomShadow = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color("backgroundT")
                    .ignoresSafeArea()

                VStack {
                    HStack {
                        Text("Rewards")
                            .font(.custom("Futura", size: 28))
                            .bold()
                            .padding()
                            .foregroundColor(Color("primaryT"))
                        Spacer()
                        ZStack {
                            NavigationLink(destination: CartView(cart: $cart, totalPoints: $totalPoints)) {
                                Image(systemName: "cart.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .padding()
                                    .foregroundColor(Color("primaryT"))
                            }
                            if cart.count > 0 {
                                Text("\(cart.count)")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 15, y: -10)
                            }
                        }
                    }
                    .padding(.horizontal)
                    HStack{
                        
                        Text("Total points:")
                            .font(.custom("Futura", size: 24))
                            .bold()
                            .foregroundColor(Color("primaryT"))
                        Text("\(totalPoints)")
                            .font(.custom("Futura", size: 24))
                            .bold()
                            .foregroundColor(Color("territoryT"))
                    }

                    Text("You have earned \(earnedPoints) points!")
                        .font(.custom("Futura", size: 22))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("primaryT"))

                    ZStack {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 1) {
                                ForEach(rewards) { reward in
                                    RewardView(reward: reward, totalPoints: $totalPoints, cart: $cart)
                                }
                            }
                            .padding()
                        }
                        .scrollIndicators(.visible)

                        if showTopShadow {
                            VStack {
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.black.opacity(0.3), Color.clear]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .frame(height: 20)
                                .edgesIgnoringSafeArea(.top)
                                
                                Spacer()
                            }
                        }

                        if showBottomShadow {
                            VStack {
                                Spacer()
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.3)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .frame(height: 20)
                                .edgesIgnoringSafeArea(.bottom)
                            }
                        }
                    }
                    
                    Text("Choose any reward to view")
                        .font(.custom("Futura", size: 22))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("secondaryT"))
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink(destination: FinalPageView()){
                            HStack {
                                Image("ic_left_arrow")
                                    .padding(.horizontal)
                                Text("Later")
                                    .font(.custom("Futura", size: 24))
                            }
                            .font(.title)
                            .padding()
                            .frame(width: 150, height: 60)
                            .foregroundColor(Color("primaryT"))
                            .cornerRadius(50)
                        }
                        .padding()

                        if cart.isEmpty {
                            NavigationLink(destination: CartView(cart: $cart, totalPoints: $totalPoints)) {
                                Text("Next")
                                    .font(.custom("Futura", size: 24))
                                    .padding()
                                    .frame(width: 150, height: 60)
                                    .background(Color("primaryT"))
                                    .foregroundColor(.white)
                                    .cornerRadius(50)
                            }
                        } else {
                            NavigationLink(destination: RewardDetailView(selectedRewards: $cart)) {
                                Text("Next")
                                    .font(.custom("Futura", size: 24))
                                    .padding()
                                    .frame(width: 150, height: 60)
                                    .background(Color("primaryT"))
                                    .foregroundColor(.white)
                                    .cornerRadius(50)
                            }
                        }

                        Spacer()
                    }
                }
            }
        }
    }
}

struct ListRewards_Previews: PreviewProvider {
    static var previews: some View {
        ListRewards()
    }
}
