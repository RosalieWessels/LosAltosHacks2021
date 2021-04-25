//
//  AccountView.swift
//  Password Manager
//
//  Created by Carolyn Steeg on 4/24/21.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        ZStack {
            Color("backgroundColor").edgesIgnoringSafeArea(.all)
            
            
            VStack {
                HStack {
                    Text("Your Account:")
                        .padding(.leading, 10)
                        .padding(.top, 50)
                        .font(Font .custom("ArialRoundedMTBold", size: 50))
                        Spacer()
                
                
                Spacer()
                            
                }
                HStack {
                    Text("Email:")
                        .padding(.leading, 10)
                        .padding(.top, 50)
                        .font(Font .custom("ArialRoundedMTBold", size: 25))
                        Spacer()
                
                }
                
                HStack {
                    Text("# of Passwords:")
                        .padding(.leading, 10)
                        .padding(.top, 50)
                        .font(Font .custom("ArialRoundedMTBold", size: 25))
                        Spacer()
                Spacer()
                }
                Spacer()
                
                Button(action: {}) {
                                    Text("Log out")
                .foregroundColor(.black)
                .fontWeight(.heavy)
                            }
                            .padding()
                .background(Color.white)
                            .cornerRadius(25)
                            .shadow(radius:3)
                
            }
        }
    }
}




struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
