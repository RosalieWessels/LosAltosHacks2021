//
//  AddNewPassword.swift
//  Password Manager
//
//  Created by Rosalie Wessels on 4/24/21.
//

import SwiftUI

struct AddNewPasswordView: View {
    var body: some View {
        ZStack {
            Color("backgroundColor").edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Add a New Password")
                    .font(Font.system(size: 30))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.bottom)
            }
        }
    }
}

struct AddNewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPasswordView()
    }
}
