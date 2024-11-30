//
//  CodeGeneratorView.swift
//  FastRewardClip
//
//  Created by Asadbek Nematov on 7/11/24.
//

import SwiftUI

struct CodeGeneratorView: View {
    @Binding var cart: [Reward]
    @State private var randomCode: Int = Int.random(in: 10...99)
    @State private var expirationDate: Date = Calendar.current.date(byAdding: .minute, value: 10, to: Date())!

    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            // Background Ellipse
            Ellipse()
                .fill(Color.backgroundT)
                .frame(width: 1200, height: 800)
                .offset(y: 260)
        VStack {
            Text("Show the code to cashier!")
                .font(.custom("Futura-Bold", size: 24))
                .frame(width: 300)
                .multilineTextAlignment(.center)
                .padding(.top, 30)
                .foregroundColor(Color("primaryT"))
            
            Text("\(randomCode)")
                .font(.custom("Futura-Bold", size: 60))
                .bold()
                .padding(.top, 1)
                .foregroundColor(Color("territoryT"))
            
            Text("Expire in 10 minutes")
                .font(.custom("Futura", size: 16))
                .padding(.top, 0)
                .foregroundColor(.gray)
            
            Text("EXP: \(formattedExpirationDate())")
                .font(.custom("Futura", size: 16))
                .padding(.top, 0)
                .foregroundColor(.gray)
            
            VStack(spacing: 10) {
                HStack {
                        Text("Vietnamese Restaurant")
                            .font(.custom("Futura", size: 24))
                            .bold()
                            .padding()
                            .foregroundColor(Color("primaryT"))
                    Spacer()
                }
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(cart) { reward in
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
                                }
                                .frame(width: 300)
                            }
                        }
                    }
                    .padding()
                }
                
                HStack {
                    Text("Total")
                        .font(.custom("Futura", size: 20))
                        .padding(.horizontal)
                        .foregroundColor(Color("primaryT"))
                    Spacer()
                    Text("\(cart.count) rewards")
                        .font(.custom("Futura", size: 20))
                        .padding(.horizontal)
                        .foregroundColor(Color("primaryT"))
                }
                .padding(.bottom, 20)
            }
            .frame(width: 395)
            .padding(.top, 60)
            
            NavigationLink(destination: FinalPageView()) {
                Text("Received")
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
        .navigationBarColor(UIColor(named: "blankT"), titleColor: UIColor(named:"territoryT"))
        .background(Color("white").ignoresSafeArea())
        .navigationBarTitle("Code Generator", displayMode: .automatic)
    }

    private func formattedExpirationDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM-dd-yyyy HH:mm:ss"
        return formatter.string(from: expirationDate)
    }
}

struct CodeGeneratorView_Previews: PreviewProvider {
    @State static var cart: [Reward] = [
        Reward(name: "$2 OFF", pointsRequired: 6, image: "reward5"),
        Reward(name: "$2 OFF", pointsRequired: 9, image: "reward1"),
        Reward(name: "$2 OFF", pointsRequired: 8, image: "reward2")
    ]

    static var previews: some View {
        CodeGeneratorView(cart: $cart)
    }
}
