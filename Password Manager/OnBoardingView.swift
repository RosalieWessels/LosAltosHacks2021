//
//  OnBoardingView.swift
//  Password Manager
//
//  Created by Rosalie Wessels on 4/24/21.
//

import SwiftUI
import Firebase

struct OnBoardingView: View {
    
    @AppStorage("log_Status") var status = DefaultStatus.status
    @StateObject var model = ModelData()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("backgroundColor").ignoresSafeArea()
                
                if status == true {
                    ContentView()
                }
                else {
                    VStack {
                        Spacer()
                        
                        Text("Welcome to EasyAccess")
                            .font(Font.system(size: 40))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        //Image from: https://blush.design/collections/stuck-at-home
                        Image("Stuck at Home - Secured")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        NavigationLink(destination: LogInScreen(model: model)) {
                            Text("Get Started!")
                                .font(.title2)
                                .foregroundColor(.white)
                                .padding(.vertical)
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color("gray"))
                        .cornerRadius(20)
                        .padding()
                    
                    }
                }
            }
        }
        .onAppear(perform: {
            checkStatus()
        })
    }
    
    func checkStatus() {
        if status == true {
            print("LOGGED IN IN DIFFERENT VEW")
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
