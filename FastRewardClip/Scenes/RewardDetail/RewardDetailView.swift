//
//  RewardDetailView.swift
//  TaperkClip
//
//  Created by Asadbek Nematov on 6/14/24.
//

import SwiftUI

struct RewardDetailView: View {
    @Binding var selectedRewards: [Reward]
    
    // Sample rewards for the "More Rewards" section
    @State private var moreRewards: [Reward] = [
        Reward(name: "Free Scoop", pointsRequired: 4, image: "reward5"),
        Reward(name: "50% Off For Medium Pizza", pointsRequired: 8, image: "reward3"),
        Reward(name: "Free Chicken Nuggets", pointsRequired: 5, image: "reward4")
    ]
    
    @State private var showMoreRewards = false
    @State private var offsetY: CGFloat = UIScreen.main.bounds.height
    @State private var selectedTab = 0


    var body: some View {
        ZStack(alignment: .top) {
            
            // Background Ellipse
            Ellipse()
                .fill(Color.secondaryT)
                .frame(width: 900, height: 400)
                .offset(y: -100)
            
            VStack {
                // Header Text
                Text("Ready to redeem!")
                    .font(.custom("Futura", size: 24))
                    .bold()
                    .padding(.top, 50)
                    .foregroundColor(Color.white)
                HStack{
                    Image("left_drops")
                        .padding(0)
                    HStack {
                        Image("crown1")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text( "**6/6**")
                            .foregroundColor(Color.white)
                            .bold()
                            .padding(.horizontal, 5)
                    }
                    .padding(5)
                    .padding(.horizontal, 2)
                    .font(.custom("Futura", size: 24))
                    .background( Color("territoryT"))
                    .cornerRadius(50)
                        Image("right_drops")
                            .padding(1)
                            .offset(y:-20)
        
                }

                // Selected Rewards TabView with Custom Page Indicators
                if !selectedRewards.isEmpty {
                    VStack {
                        TabView(selection: $selectedTab) {
                            ForEach(0..<selectedRewards.count, id: \.self) { index in
                                RewardDetailItemView(reward: selectedRewards[index])
                                    .tag(index)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .frame(height: 440)
                        CustomPageIndicator(numberOfPages: selectedRewards.count, currentIndex: selectedTab)
                    }
                }
                Spacer()
                // Action Buttons
                HStack {
                    Spacer()
                    
                    // "Later" Button
                    NavigationLink(destination: FinalPageView()) {
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
                    
                    // "Add Cart" Navigation Link
                    NavigationLink(destination: CartView(cart: $selectedRewards, totalPoints: .constant(14))) {
                        Text("Add Cart")
                            .font(.custom("Futura", size: 24))
                            .padding()
                            .frame(width: 150, height: 60)
                            .background(Color("primaryT"))
                            .foregroundColor(.white)
                            .cornerRadius(50)
                    }
                    .padding()

                    Spacer()
                }
                
                Spacer()
                
                // "See More Rewards" Section
                if !showMoreRewards {
                    VStack {
                        Text("See more rewards")
                            .foregroundColor(Color("primaryT"))
                            .padding()
                        
                        Image(systemName: "chevron.compact.up")
                            .foregroundColor(Color("primaryT"))
                            .padding(.bottom, 30)
                    }
                    .onTapGesture {
                        withAnimation {
                            showMoreRewards.toggle()
                            offsetY = showMoreRewards ? UIScreen.main.bounds.height / 4 : UIScreen.main.bounds.height
                        }
                    }
                }
            }
            
            // More Rewards View
            MoreRewardsView(rewards: moreRewards)
                .offset(y: offsetY)
                .background(Color.black.opacity(showMoreRewards ? 0.5 : 0).edgesIgnoringSafeArea(.all))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.height > 0 {
                                offsetY = UIScreen.main.bounds.height / 4 + value.translation.height
                            } else {
                                offsetY = UIScreen.main.bounds.height / 4 + value.translation.height / 4
                            }
                        }
                        .onEnded { value in
                            if value.translation.height > 100 {
                                withAnimation {
                                    showMoreRewards = false
                                    offsetY = UIScreen.main.bounds.height
                                }
                            } else {
                                withAnimation {
                                    offsetY = UIScreen.main.bounds.height / 4
                                }
                            }
                        }
                )
                .onAppear {
                    offsetY = UIScreen.main.bounds.height
                }
        }
        .navigationBarTitle("Reward Details", displayMode: .automatic)
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.height < 0 {
                        offsetY = UIScreen.main.bounds.height + value.translation.height
                    }
                }
                .onEnded { value in
                    if value.translation.height < -100 {
                        withAnimation {
                            showMoreRewards = true
                            offsetY = UIScreen.main.bounds.height / 4
                        }
                    } else {
                        withAnimation {
                            offsetY = UIScreen.main.bounds.height
                        }
                    }
                }
        )
        .navigationBarColor(UIColor(named: "blankT"), titleColor: UIColor(named: "primaryT")) // Apply custom appearance
//        //needs to be fixed
//        .background(HomeIndicatorController())

    }

}

// Custom Page Indicator
struct CustomPageIndicator: View {
    var numberOfPages: Int
    var currentIndex: Int
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == currentIndex ? Color("primaryT") : Color("secondaryT"))
                    .frame(width: index == currentIndex ? 12 : 8, height: index == currentIndex ? 12 : 8)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: currentIndex) // Updated animation
    }
}

struct RewardDetailView_Previews: PreviewProvider {
    @State static var selectedRewards: [Reward] = [
        Reward(name: "Free Pho Noodle", pointsRequired: 6, image: "reward5"),
        Reward(name: "Free Normal Size Spaghetti", pointsRequired: 6, image: "reward1"),
    ]
    
    static var previews: some View {
        RewardDetailView(selectedRewards: $selectedRewards)
    }
}
