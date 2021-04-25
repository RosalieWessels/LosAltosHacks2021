//
//  SeePasswordView.swift
//  Password Manager
//
//  Created by Rosalie Wessels on 4/24/21.
//

import SwiftUI

struct SeePasswordView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Google:")
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
                Text("Password:")
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




struct SeePassword_Previews: PreviewProvider {
    static var previews: some View {
        SeePasswordView()
    }
}
