//
//  SeePasswordView.swift
//  Password Manager
//
//  Created by Rosalie Wessels on 4/24/21.
//

import SwiftUI
import SSSwiftUIGIFView

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
                        .font(Font .custom("ArialRoundedMTBold", size: 30))
                        Spacer()
                
                
                Spacer()
                            
                }
                HStack {
                    Text("Email: \n'\(passwordData.email)'")
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                        .padding(.top, 50)
                        .font(Font .custom("ArialRoundedMTBold", size: 20))
                        Spacer()
                
                }
                
                HStack {
                    Text("Password: \n'\(passwordData.pasword)'")
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                        .padding(.top, 50)
                        .font(Font .custom("ArialRoundedMTBold", size: 20))
                        Spacer()
                Spacer()
                }
                
                SwiftUIGIFPlayerView(gifName: "\(passwordData.company)")
                    .cornerRadius(25)
                    
                
                Spacer()
            }
            .padding()
        }
        
    }
}

struct SeePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        SeePasswordView(passwordData: Password(company: "Google", email: "23csteeg@pinewood.edu", pasword: "myNicePassword"))
    }
}
