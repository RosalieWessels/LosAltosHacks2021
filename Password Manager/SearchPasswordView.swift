//
//  SearchPasswordView.swift
//  Password Manager
//
//  Created by Rosalie Wessels on 4/24/21.
//

import SwiftUI

struct SearchPasswordView: View {
    var body: some View {
        ZStack {
            
            Color("backgroundColor").edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Search")
                    .foregroundColor(.white)
            }
        }
    }
}

struct SearchPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPasswordView()
    }
}
