//
//  ContentView.swift
//  Password Manager
//
//  Created by Rosalie Wessels on 4/24/21.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        ZStack {
            Color("backgroundColor").ignoresSafeArea(edges: .top)
            
            VStack {
                ScrollView {
                    VStack (spacing: 0) {
                        
                        
                        
                        ScrollView (.vertical, showsIndicators: false) {
                            
                            VStack (spacing: 25) {
                                Card()
                                
                                Card()
                            }
                            
                            
                            
                        }
                        .padding(.horizontal, 25)
                        .padding(.top, 25)
                        
                    }
                }
                TabBar()
            }
            
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//Custom Divider from https://stackoverflow.com/questions/56619043/show-line-separator-view-in-swiftui/56619112
struct CustomDivider: View {
    let height: CGFloat = 0.5
    let color: Color = Color("dividerColor")
    let opacity: Double = 1
    
    var body: some View {
        Group {
            Rectangle()
        }
        .frame(height: height)
        .foregroundColor(color)
        .opacity(opacity)
    }
}


struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(Font.custom("ArialMT", size: 14))
            .foregroundColor(.white)
            .padding(10)
            .background(Color("textFieldBackgroundColor"))
            .cornerRadius(12)
    }
}



struct Card: View {
    @State var textFieldText : String = ""
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image("profilePic")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 63)
                        .padding(.trailing, 15)
                        .padding(.leading, 15)
                        .padding(.top, 15)
                    
                    VStack (alignment: .leading, spacing: 6) {
                        Text("Alice Smith")
                            .foregroundColor(.white)
                            .font(Font.custom("Arial-BoldMT", size: 16))
                        Text("20 April at 4:20 PM")
                            .foregroundColor(Color("grayTextColor"))
                            .font(Font.custom("ArialMT", size: 14))
                    }
                    
                    Spacer()
                    
                    Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "chevron.forward")
                            .padding(.trailing, 20)
                            .padding(.top, 15)
                            .foregroundColor(.white)
                    }
                }
                
                
                
            }
        }
        .padding(.bottom, 15)
        .background(Color("gray"))
        .cornerRadius(25)
    }
}

struct TabBar: View {
    var body: some View {
        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
            HStack {
                Spacer()
                Image(systemName: "waveform.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
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
