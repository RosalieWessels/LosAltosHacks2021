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
                    
                    if PasswordStrength.of(password: password) == .none {
                        Text("Add password to see your score")
                            .foregroundColor(.white)
                    }
                    
                    if PasswordStrength.of(password: password) == .low {
                        if password != "password" {
                            Text("Terrible - cracked within a couple minutes/hours")
                                .foregroundColor(.red)
                        }
                        
                        if password == "password" {
                            Text("Really? Password as a password?? Dumb.")
                                .foregroundColor(.red)
                        }
                        
                    }
                    
                    if PasswordStrength.of(password: password) == .medium {
                        Text("Its getting a bit better... - cracked within a day")
                            .foregroundColor(.orange)
                    }
                    
                    VStack {
                        
                        if PasswordStrength.of(password: password) == .high {
                            Text("AMAZING AND INDESTRUCTABLE")
                                .foregroundColor(.green)
                        }
                    }
                    

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


//https://github.com/josa42/swift-simple-password-strength-checker/blob/master/Sources/SimplePasswordChecker/PasswordStrength.swift
enum PasswordStrength {
case none, low, medium, high

  static func of(password: String) -> PasswordStrength {

    let scere = scereOf(password: password)


    switch(scere) {
    case 0: return .none
    case 1...2: return .low
    case 3...4: return .medium
    default: return .high
    }
  }

  static func scereOf(password: String) -> Int {
    var score = 0

    // At least one lowercase letter
    if test(password, matches: "[a-züöäß]") {
      score += 1
    }

    // At least one uppercase
    if test(password, matches: "[A-ZÜÖÄß]") {
      score += 1
    }

    // At least one number
    if test(password, matches: "[0-9]") {
      score += 1
    }

    // At least one special character
    if test(password, matches: "[^A-Za-z0-9üöäÜÖÄß]") {
      score += 1
    }

    // A length of at least 8 characters
    if password.count >= 16 {
      score += 2

    } else if password.count >= 8 {
      score += 1
    }

    return score
  }

  static func test(_ password: String, matches: String) -> Bool {
    return password.range(of: matches, options: .regularExpression) != nil
  }
}
