//
//  SeePasswordView.swift
//  Password Manager
//
//  Created by Rosalie Wessels on 4/24/21.
//

import SwiftUI

struct SeePasswordView: View {
    
    @State var passwordData : Password
    
    var body: some View {
        ZStack {
            Color("backgroundColor").edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Company: \(passwordData.company)")
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                        .padding(.top, 50)
                        .font(Font .custom("ArialRoundedMTBold", size: 50))
                        Spacer()
                
                
                Spacer()
                            
                }
                HStack {
                    Text("Email: '\(passwordData.email)'")
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                        .padding(.top, 50)
                        .font(Font .custom("ArialRoundedMTBold", size: 25))
                        Spacer()
                
                }
                
                HStack {
                    Text("Password: '\(passwordData.pasword)'")
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                        .padding(.top, 50)
                        .font(Font .custom("ArialRoundedMTBold", size: 25))
                        Spacer()
                Spacer()
                }
                Spacer()
            }
        }
        
    }
}
