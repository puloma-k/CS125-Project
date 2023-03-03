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
                NavQuestionnaireView()
            } else {
                StartScreenView(signInSuccess: $signInSuccess)
            }
        }
    }
}


struct StartScreenView: View {
    @State var email = ""
    @State var password = ""
    @State var loginFail = false
    
    @Binding var signInSuccess: String

    var body: some View {
        ZStack {
            Color("MainBackground").ignoresSafeArea()
            VStack {
                HStack() {
                    Text("MeMind")
                        .font(Font.custom("AlegreyaRoman-Medium", size: 40))
                    Image("plant")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 50, height: 50)
                }
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                Spacer().frame(height: 25)
                HStack(spacing: 40) {
                    Button(action: { login() }) {
                        Text("Login")
                            .padding(8)
                            .foregroundColor(Color("Tertiary"))
                            .overlay(
                                Capsule(style: .continuous)
                                    .stroke(Color("Tertiary"), lineWidth: 2)
                            )
                    }
                    .alert(
                        "Login failed. Please try again.",
                        isPresented: $loginFail
                    ) {}
                    Button(action: { signup() }) {
                        Text("Sign up")
                            .padding(8)
                            .foregroundColor(Color("Tertiary"))
                            .overlay(
                                Capsule(style: .continuous)
                                    .stroke(Color("Tertiary"), lineWidth: 2)
                            )
                    }
                }
            }
            .padding()
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("an error occured: \(error.localizedDescription)")
                self.loginFail = true
                return
            }
            self.signInSuccess = "loggedIn"
        }
    }
    
    func signup() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("an error occured: \(error.localizedDescription)")
                self.loginFail = true
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
