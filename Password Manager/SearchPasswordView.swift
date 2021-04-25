//
//  SearchPasswordView.swift
//  Password Manager
//
//  Created by Rosalie Wessels on 4/24/21.
//

import SwiftUI
import Firebase

struct SearchPasswordView: View {
    @State var textFieldText = ""
    @State var db = Firestore.firestore()
    @State var passwords = [Password(company: "startCompany", email: "startEmail", pasword: "startCompany")]
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor").edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    Text("Search for a password")
                        .font(Font.system(size: 30))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    TextField("Type a company name...", text: $textFieldText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        searchForPasswords()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                            .padding(.all, 5)
                    }
                }
                .padding()
                .frame(maxHeight: 30)
                
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack (spacing: 25) {
                        if passwords[0].company != "startCompany" {
                            ForEach(passwords) { result in
                                SearchCard(passwordData: result)
                            }
                            

                        }
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                
                Spacer()
                
            }
        }
        .onAppear {
            searchForPasswords()
        }
    }
    
    func searchForPasswords() {
        passwords = [Password(company: "startCompany", email: "startEmail", pasword: "startCompany")]
        if textFieldText != "" {
            db.collection("\(Auth.auth().currentUser?.email ?? "")").whereField("company", isEqualTo: textFieldText)
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            print("\(document.documentID) => \(document.data())")
                            if let company = document.get("company") as? String {
                                if let email = document.get("email") as? String {
                                    if let password = document.get("password") as? String {
                                        passwords.append(Password(company: company, email: email, pasword: password))
                                    }
                                }
                            }
                        }
                        print(passwords)
                        passwords.remove(at: 0)
                    }
            }
        }
        else {
            db.collection("\(Auth.auth().currentUser?.email ?? "")")
                .getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            print("\(document.documentID) => \(document.data())")
                            if let company = document.get("company") as? String {
                                if let email = document.get("email") as? String {
                                    if let password = document.get("password") as? String {
                                        passwords.append(Password(company: company, email: email, pasword: password))
                                    }
                                }
                            }
                        }
                        print(passwords)
                        passwords.remove(at: 0)
                    }
            }
        }
    }
    
}

struct SearchPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPasswordView()
    }
}

struct SearchCard: View {
    @State var passwordData : Password
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(passwordData.company)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 50)
                        .padding(.trailing, 15)
                        .padding(.leading, 15)
                        .padding(.top, 15)
                    
                    VStack (alignment: .leading, spacing: 6) {
                        Text(passwordData.company)
                            .foregroundColor(.white)
                            .font(Font.custom("Arial-BoldMT", size: 16))
                        Text(passwordData.email)
                            .foregroundColor(Color("grayTextColor"))
                            .font(Font.custom("ArialMT", size: 14))
                    }
                    .padding(.top, 15)
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity)
                
                HStack {
                    Text("Password: '\(passwordData.pasword)'")
                        .foregroundColor(Color("grayTextColor"))
                        .font(Font.custom("Arial-MT", size: 14))
                    Spacer()
                }
                .padding(.horizontal, 15)
                .padding(.top)
            }
        }
        .padding(.bottom, 15)
        .background(Color("gray"))
        .cornerRadius(25)
    }
}
