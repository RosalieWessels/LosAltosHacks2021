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
                        .font(Font .custom("ArialRoundedMTBold", size: 35))
                        Spacer()
                
                
                Spacer()
                            
                }
                HStack {
                    Text("Email: \n'\(passwordData.email)'")
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                        .padding(.top, 50)
                        .font(Font .custom("ArialRoundedMTBold", size: 25))
                        Spacer()
                
                }
                
                HStack {
                    Text("Password: \n'\(passwordData.pasword)'")
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

struct SeePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        SeePasswordView(passwordData: Password(company: "Google", email: "23csteeg@pinewood.edu", pasword: "myNicePassword"))
    }
}
