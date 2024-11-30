//
//  FinalPageView.swift
//  FastRewardClip
//
//  Created by Asadbek Nematov on 7/11/24.
//

import SwiftUI

struct FinalPageView: View {
    var body: some View {
        
        ZStack(alignment: .bottom) {
            
            // Background Ellipse
            Ellipse()
                .fill(Color.backgroundT)
                .frame(width: 1100, height: 800)
                .offset(y: 160)
            VStack {
                Text("Don't miss other rewards!")
                    .font(.custom("Futura-Bold", size: 30))
                    .bold()
                    .padding(.top, 30)
                    .padding()
                    .frame(width: 300)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("secondaryT"))
                
                Text("Follow us on Instagram for limited rewards!!!")
                    .font(.custom("Futura-Bold", size: 30))
                    .bold()
                    .frame(width: 300)
                    .padding(.top, 50)
                    .padding()
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("primaryT"))
                
                Image("logo") // Replace with your logo image name
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.top, 20)
                
                Text("Fast Reward")
                    .font(.custom("Futura-Bold", size: 24))
                    .bold()
                    .foregroundColor(Color("primaryT"))
                    .padding(.top, 10)
                
                Spacer()
                
                HStack {
                    Button(action: {
                        // Handle Exit action
                        exitApp()
                    }) {
                        Text("Exit")
                            .font(.custom("Futura", size: 20))
                            .padding()
                            .frame(width: 120, height: 50)
                            .background(Color("secondaryT"))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                    .padding(.horizontal, 20)
                    
                    Button(action: {
                        // Handle Follow action
                        openInstagram()
                    }) {
                        Text("Follow")
                            .font(.custom("Futura", size: 20))
                            .padding()
                            .frame(width: 120, height: 50)
                            .background(Color("primaryT"))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 60)
            }
        }
        .navigationBarColor(UIColor(named: "blankT"), titleColor: UIColor(named:"territoryT"))
        .navigationBarTitle("Final Page", displayMode: .automatic)
    }
    
    private func exitApp() {
        // Function to close the app
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            exit(0)
        }
    }
    
    private func openInstagram() {
        // Function to open Instagram
        let instagramURL = URL(string: "https://www.instagram.com/fastreward.us?igsh=MXcyc2s5MTY5aHhtZQ==")! // Replace with your Instagram account URL
        if UIApplication.shared.canOpenURL(instagramURL) {
            UIApplication.shared.open(instagramURL, options: [:], completionHandler: nil)
        }
    }
}

struct FinalPageView_Previews: PreviewProvider {
    static var previews: some View {
        FinalPageView()
    }
}
