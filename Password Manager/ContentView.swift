//
//  ContentView.swift
//  Password Manager
//
//  Created by Rosalie Wessels on 4/24/21.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import SwiftSpeech
import AVFoundation

struct ContentView: View {
    
    @StateObject var model = ModelData()
    @State var user = Auth.auth().currentUser
    @State var db = Firestore.firestore()

    @State var spokenText = ""
    
    @State var userWantsSpoken = false
    @State var findPasswordSpoken = false
    @State var addPasswordSpoken = false
    @State var addPasswordEmail = ""
    @State var addPasswordCompany = ""
    @State var addPasswordPassword = ""
    
    @State var passwords = [Password(company: "startCompany", email: "startEmail", pasword: "startCompany")]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("backgroundColor").ignoresSafeArea(edges: .top)
                
                VStack {
                            
                    ScrollView (.vertical, showsIndicators: false) {
                        
                        VStack (spacing: 25) {
                            
                            HStack (spacing: 25){
                                AddNewPasswordCard()
                                
                                searchCard()
                            }
                            
                            
                            
                            Image("Stuck at Home - Happy Place")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(.horizontal, 60)
                           
                            
                            if passwords[0].company != "startCompany" {
                                ForEach(passwords) { result in
                                    Card(company: result.company, email: result.email, image: result.company, passwordData: result)
                                }
                                

                            }
                            
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 25)
                       
                    
                    //Tab Bar
                    if userWantsSpoken == false {
                        Button(action: {
                            startSpeechRecognition()
                        }) {
                            HStack {
                                Spacer()
                                Text("Press for Voice Control")
                                    .foregroundColor(.white)
                                    .font(Font.custom("Arial-BoldMT", size: 20))
                                
                                Spacer()
                                
                                Image(systemName: "waveform.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .foregroundColor(.white)
                                    .frame(maxHeight: 45)
                                    .padding(.vertical)
                                Spacer()
                            }
                        }
                        .background(
                            RoundedCorners(color: Color("gray"), tl: 12, tr: 12, bl: 0, br: 0)
                                .edgesIgnoringSafeArea(.bottom)
                        )
                    }
                    else {
                        VStack {
                            Text(spokenText)
                                .foregroundColor(.white)
                            
                            HStack {
                                Spacer()
                                
                                SwiftSpeech.RecordButton()
                                    .swiftSpeechRecordOnHold()
                                    .onRecognizeLatest(update: $spokenText)
                                    .onStopRecording(appendAction: interpretResults)
                                    .padding(25)
                                    .frame(maxHeight: 96)
                                
                                Spacer()
                            }
                        }
                        .background(
                            RoundedCorners(color: Color("gray"), tl: 12, tr: 12, bl: 0, br: 0)
                                .edgesIgnoringSafeArea(.bottom)
                        )
                    }
                    
                    
                    
                }
                
            }
            .navigationBarHidden(false)
            .navigationBarTitle("EasyAccess", displayMode: .automatic)
            .navigationBarColor(backgroundColor: .backgroundColor, titleColor: .white)
            .navigationBarItems(trailing: HStack (spacing: 25) {
                Button(action: {
                    grabAllData()
                }) {
                    Image(systemName: "arrow.clockwise")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(idealHeight: 20)
                }
                
                NavigationLink(destination: AccountView()) {
                     Image(systemName: "person.crop.circle.fill")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(idealHeight: 20)
                 }
                
                NavigationLink(destination: SearchPasswordView()) {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(idealHeight: 20)
                }
                
                
            })
        }
        .onAppear(perform: {
            SwiftSpeech.requestSpeechRecognitionAuthorization()
            
            grabAllData()
        })

    }
    
    func startSpeechRecognition() {
        userWantsSpoken = true
        
        
        speakText(voiceOutdata: "Welcome, do you want to add a new password or find a password?")
        
    }
    
    func interpretResults(sesson: SwiftSpeech.Session) {
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            if spokenText == "Find a password" || spokenText == "Find password" {
                speakText(voiceOutdata: "Great! Let's find a password")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    speakText(voiceOutdata: "Which companies's password do you want to find?")
                    findPasswordSpoken = true
                }
            }
            if spokenText == "Add a new password" || spokenText == "Add new password" || spokenText == "Add password" || spokenText == "Add a password" {
                speakText(voiceOutdata: "All right dude. Let's add a new password.")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    speakText(voiceOutdata: "What companies's password do you want to add?")
                    addPasswordSpoken = true
                }
                
            }
            
            if spokenText == "I love Facebook" {
                speakText(voiceOutdata: "Ew! Please stay far away from me.")
            }
            
            if spokenText == "I love TickTock" || spokenText == "I love TikTok"{
                speakText(voiceOutdata: "Good choice. Good Choice.")
            }
            
            if spokenText == "No" {
                speakText(voiceOutdata: "Boohoo. You awoke me from my beauty sleep.")
            }
            
            
            if findPasswordSpoken == true {
                var passwordsFound : [Password] = []
                
                speakText(voiceOutdata: "Finding your password for \(spokenText)")
                
                db.collection("\(Auth.auth().currentUser?.email ?? "")").whereField("company", isEqualTo: spokenText)
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                print("\(document.documentID) => \(document.data())")
                                if let company = document.get("company") as? String {
                                    if let email = document.get("email") as? String {
                                        if let password = document.get("password") as? String {
                                            passwordsFound.append(Password(company: company, email: email, pasword: password))
                                        }
                                    }
                                }
                            }
                            
                            if passwordsFound.count > 1 {
                                speakText(voiceOutdata: "We found multiple accounts.")
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                    
                                    var waitTime = 0.0
                                    for password in passwordsFound {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + waitTime) {
                                            let password_spelled_out =  password.pasword.map(String.init(describing:)).joined(separator: " ")
                                            speakText(voiceOutdata: "We found a \(password.company) account with email adress \(password.email) and password \(password_spelled_out) ")
                                            
                                        }
                                        waitTime += 10.0
                                    }
                                }
                                
                                
                            }
                            else {
                                for password in passwordsFound {
                                    
                                    let password_spelled_out =  password.pasword.map(String.init(describing:)).joined(separator: " ")
                                    
                                    speakText(voiceOutdata: "We found a \(password.company) account with email adress \(password.email) and password \(password_spelled_out) ")
                                }
                            }
                            
                            findPasswordSpoken = false
                        }
                }
                
            }
            
            if addPasswordSpoken == true && addPasswordEmail == "" {
                addPasswordCompany = spokenText
                speakText(voiceOutdata: "What is your email address for \(addPasswordCompany)?")
                addPasswordEmail = "add Email"
                
            }
            
            else if addPasswordSpoken == true && addPasswordPassword == "" && addPasswordEmail != "" {
                addPasswordEmail = spokenText
                speakText(voiceOutdata: "What is your password for \(addPasswordCompany)")
                addPasswordPassword = "add Password"
            }
            
            else if addPasswordSpoken == true && addPasswordEmail != "" && addPasswordPassword != "" {
                addPasswordPassword = spokenText
                speakText(voiceOutdata: "All right. We are saving your new password right now.")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    uploadPasswordToFirebase()                }
                
            }
            
        }
        
    }
    
    //speakText from https://stackoverflow.com/questions/53009032/avspeechsynthesizer-is-not-working-after-use-one-time
    func speakText(voiceOutdata: String ) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }

        let utterance = AVSpeechUtterance(string: voiceOutdata)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")

        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)

        defer {
            disableAVSession()
        }
    }

    private func disableAVSession() {
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't disable.")
        }
    }
    
    func uploadPasswordToFirebase() {
        print(addPasswordPassword, addPasswordCompany, addPasswordEmail)
        db.collection("\(Auth.auth().currentUser?.email ?? "")").document().setData([
            "company": addPasswordCompany,
            "email": addPasswordEmail,
            "password": addPasswordPassword
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                addPasswordSpoken = false
                grabAllData()
            }
        }
    }
    
    func grabAllData() {
        passwords = [Password(company: "startCompany", email: "startEmail", pasword: "startCompany")]
        db.collection("\(Auth.auth().currentUser?.email ?? "")").order(by: "company", descending: false).limit(to: 10)
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

struct Card: View {
    @State var company : String
    @State var email : String
    @State var image : String
    @State var passwordData : Password
    
    var body: some View {
        NavigationLink(destination: SeePasswordView(passwordData: passwordData)) {
            VStack {
                HStack {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 50)
                        .padding(.trailing, 15)
                        .padding(.leading, 15)
                        .padding(.top, 15)
                    
                    VStack (alignment: .leading, spacing: 6) {
                        Text(company)
                            .foregroundColor(.white)
                            .font(Font.custom("Arial-BoldMT", size: 16))
                        Text(email)
                            .foregroundColor(Color("grayTextColor"))
                            .font(Font.custom("ArialMT", size: 14))
                    }
                    .padding(.top, 15)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                        .padding(.trailing, 20)
                        .padding(.top, 15)
                        .foregroundColor(.white)
                    
                }
                
            }
        }
        .padding(.bottom, 15)
        .background(Color("gray"))
        .cornerRadius(25)
    }
}

//Code from https://stackoverflow.com/questions/56760335/round-specific-corners-swiftui

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    var body: some View {
        GeometryReader { geometry in
            Path { path in

                let w = geometry.size.width
                let h = geometry.size.height

                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)

                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
        }
    }
}

struct Password: Identifiable {
    var id = UUID()
    var company : String
    var email : String
    var pasword : String
}

extension UIColor {

    static let backgroundColor = UIColor(red: 34/255, green: 52/255, blue: 60/255, alpha: 1)
    

}

//Added function to change Navigation Bar with code from: https://stackoverflow.com/questions/56505528/swiftui-update-navigation-bar-title-color
struct NavigationBarModifier: ViewModifier {

    var backgroundColor: UIColor?
    var titleColor: UIColor?

    init(backgroundColor: UIColor?, titleColor: UIColor?) {
        self.backgroundColor = backgroundColor
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = backgroundColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: titleColor ?? .white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor ?? .white]

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }

    func body(content: Content) -> some View {
        ZStack{
            content
            VStack {
                GeometryReader { geometry in
                    Color(self.backgroundColor ?? .clear)
                        .frame(height: geometry.safeAreaInsets.top)
                        .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
        }
    }
}

extension View {

    func navigationBarColor(backgroundColor: UIColor?, titleColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor, titleColor: titleColor))
    }

}

struct AddNewPasswordCard: View {
    
    var body: some View {
        NavigationLink(destination: AddNewPasswordView()) {
            Image(systemName: "plus.app")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.white)
            .frame(maxHeight: 60)
        }
        .padding(50)
        .background(Color("gray"))
        .cornerRadius(25)
        
    }
}

struct searchCard: View {
    
    var body: some View {
        NavigationLink(destination: SearchPasswordView()) {
            Image(systemName: "magnifyingglass")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.white)
            .frame(maxHeight: 60)
        }
        .padding(50)
        .background(Color("gray"))
        .cornerRadius(25)
        
    }
}
