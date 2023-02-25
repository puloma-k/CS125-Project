//
//  StartScreenView.swift
//  MeMind
//
//  Created by Puloma Katiyar on 2/23/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

struct NavToView: View {
    @State var signInSuccess = "noAuth"
    
    var body: some View {
        return Group {
            if signInSuccess == "loggedIn" {
                HomeView()
            } else if signInSuccess == "signedUp" {
                InitQuestionnaireView()
            } else {
                StartScreenView(signInSuccess: $signInSuccess)
            }
        }
    }
}


struct StartScreenView: View {
    @State var email = ""
    @State var password = ""
    
    @Binding var signInSuccess: String

    var body: some View {
        VStack {
            Text("MeMind").font(.largeTitle)
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            HStack {
                Button(action: { login() }) {
                    Text("Login")
                }
                Button(action: { signup() }) {
                    Text("Sign up")
                }
            }
        }
        .padding()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("an error occured: \(error.localizedDescription)")
                return
            }
            self.signInSuccess = "loggedIn"
        }
    }
    
    func signup() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("an error occured: \(error.localizedDescription)")
                return
            }
            var ref: DatabaseReference!
            ref = Database.database().reference()
            let uid : String = (Auth.auth().currentUser?.uid)!
            ref.child("users").child(uid).setValue(["username": email])
            self.signInSuccess = "signedUp"
        }
    }

}

struct StartScreenView_Previews: PreviewProvider {
    static var previews: some View {
        NavToView()
    }
}
