//
//  UserProfileView.swift
//  MeMind
//
//  Created by Puloma Katiyar on 2/21/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct UserProfileView: View {
    var body: some View {
        ZStack {
            VStack {
                Color("MainBackground").ignoresSafeArea()
                
            }
            VStack {
                Text("this is user profile view")
            }
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
