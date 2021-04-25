//
//  AccountView.swift
//  Password Manager
//
//  Created by Carolyn Steeg on 4/24/21.
//

import SwiftUI
import Firebase

struct AccountView: View {
    
    @StateObject var model = ModelData()
    @State var user = Auth.auth().currentUser
    @State var db = Firestore.firestore()
    @State var passwordsCount = 0
    
    var body: some View {
        ZStack {
            Color("backgroundColor").edgesIgnoringSafeArea(.all)
            
            
            VStack {
                HStack {
                    Text("Your Account:")
                        .padding(.leading, 10)
                        .font(Font .custom("ArialRoundedMTBold", size: 35))
                        .foregroundColor(.white)
                        Spacer()
                
                
                Spacer()
                            
                }
                HStack {
                    Text("Email: \n\(user?.email ?? "")")
                        .padding(.leading, 10)
                        .padding(.top, 50)
                        .font(Font .custom("ArialRoundedMTBold", size: 25))
                        .foregroundColor(.white)
                        Spacer()
                
                }
                
                HStack {
                    Text("# of Passwords: \n\(passwordsCount)")
                        .padding(.leading, 10)
                        .padding(.top, 50)
                        .font(Font .custom("ArialRoundedMTBold", size: 25))
                        .foregroundColor(.white)
                        Spacer()
                Spacer()
                }
                
                Spacer()
                
                Image("Stuck at Home - Monitor")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 30)
                
                Spacer()
                
                Button(action: model.logOut) {
                    Text("Log out")
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(25)
                .shadow(radius:3)
                
            }
            .padding()
        }
        .onAppear(perform: {
            getNumberOfPasswords()
        })
    }
    
    func getNumberOfPasswords() {
        
        db.collection("\(user?.email ?? "")")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    print("SIZE", querySnapshot!.documents.count)
                    passwordsCount = querySnapshot!.documents.count
                }
        }
    }
}




struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
