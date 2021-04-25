//
//  AddNewPassword.swift
//  Password Manager
//
//  Created by Rosalie Wessels on 4/24/21.
//

import SwiftUI
import Firebase

struct AddNewPasswordView: View {
    @State var company = ""
    @State var email = ""
    @State var password = ""
    @State var user = Auth.auth().currentUser
    @State var db = Firestore.firestore()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color("backgroundColor").edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Add a New Password")
                    .font(Font.system(size: 30))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.bottom)
                
                VStack {
                    Image("Stuck at Home - Birthday Cake")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 150)
                    
                    Text("Adding a password is a piece of cake...")
                        .foregroundColor(.white)
                        .font(Font.custom("ArialMT", size: 16))
                }
                .padding(.bottom, 25)
                
                VStack (alignment: .leading, spacing: 25) {
                    
                    Text("Company:")
                        .foregroundColor(.white)
                        .font(Font.custom("Arial-BoldMT", size: 16))
                    
                    TextField("Google", text: $company)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Email:")
                        .foregroundColor(.white)
                        .font(Font.custom("Arial-BoldMT", size: 16))
                    
                    TextField("example@gmail.com", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Text("Password:")
                        .foregroundColor(.white)
                        .font(Font.custom("Arial-BoldMT", size: 16))
                    
                    SecureField("You better add a strong password..", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                }
                .padding(.horizontal)
                .padding(.bottom, 25)
                
                Button(action: {uploadPasswordToDatabase()}) {
                    Text("Add Password")
                        .foregroundColor(.white)
                        .font(Font.custom("Arial-BoldMT", size: 18))
                }
                .padding()
                .background(Color("gray"))
                .cornerRadius(20)
                
                
                
                Spacer()
                
            }
        }
    }
    
    func uploadPasswordToDatabase() {
        if company != "" && email != "" && password != "" {
            db.collection("\(Auth.auth().currentUser?.email ?? "")").document().setData([
                "company": company,
                "email": email,
                "password": password
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct AddNewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewPasswordView()
    }
}
