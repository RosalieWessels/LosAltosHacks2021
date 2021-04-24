//
//  SignUpView.swift
//  Password Manager
//
//  Created by Rosalie Wessels on 4/24/21.
//

import SwiftUI


struct SignUpView: View {
    
    @ObservedObject var model : ModelData
    
    var body: some View {
        ZStack {
            
            VStack {
                
                Text("Sign Up")
                    .font(.system(size: 40))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
                    .shadow(radius:3)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .shadow(radius:3)
                    
                    TextField("example@gmail.com", text: $model.email_SignUp)
                        .padding(.vertical)
                        .padding(.horizontal)
                        .background(Color("grayTextColor"))
                        .cornerRadius(5.0)
                        .shadow(radius:3)
                    
                    Text("Password")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .shadow(radius:3)
                    
                    SecureField("Don't you dare add a weak password.", text: $model.password_SignUp)
                        .padding(.vertical)
                        .padding(.horizontal)
                        .background(Color("grayTextColor"))
                        .cornerRadius(5.0)
                        .shadow(radius:3)
                    
                    Text("Re-enter Password")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .shadow(radius:3)
                    
                    SecureField("Please add it again.", text: $model.reEnterPassword)
                        .padding(.vertical)
                        .padding(.horizontal)
                        .background(Color("grayTextColor"))
                        .cornerRadius(5.0)
                        .shadow(radius:3)
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button(action: model.signUp) {
                    Text("Submit")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("gray"))
                        .cornerRadius(20)
                }
                .padding()
                
                
            }
            
            VStack() {
                HStack {
                    Spacer()
                    Button(action: {
                        model.isSignUp.toggle()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .font(.title)
                    }
                    .padding()
                    
                    if model.isLoading {
                        LoadingView()
                    }
                }
                Spacer()
            }
        }
        .background(Color("backgroundColor").ignoresSafeArea())
        .alert(isPresented: $model.alert, content: {
            Alert(title: Text("Message"), message: Text(model.alertMsg), dismissButton: .destructive(Text("Ok"), action: {
                
                if model.alertMsg == "Email verification has been sent!"{
                    model.isSignUp.toggle()
                    model.email_SignUp = ""
                    model.password_SignUp = ""
                    model.reEnterPassword = ""
                    
                }
                
            }))
        })
            
    }

}
