//
//  InitQuestionnaireView.swift
//  MeMind
//
//  Created by Puloma Katiyar on 2/24/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct NavQuestionnaireView: View {
    @State var nextPg = false
    
    var body: some View {
        return Group {
            if nextPg {
                NavQuestionnaire2View()
            } else {
                InitQuestionnaireView(nextPg: $nextPg)
            }
        }
    }
}

struct InitQuestionnaireView: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var age = ""
    
    @Binding var nextPg: Bool
    
    var body: some View {
        ZStack {
            Color("MainBackground").ignoresSafeArea()
            VStack {
                VStack {
                    Text("Welcome to MeMind!")
                        .font(Font.custom("AlegreyaRoman-Medium", size: 35))
                    Text("Let's get started :)")
                        .font(Font.custom("MontserratRoman-Medium", size: 17))
                }
                .padding()
                
                VStack {
                    Text("About You")
                        .font(Font.custom("MontserratRoman-Bold", size: 17))
                    VStack {
                        Text("First name")
                            .font(Font.custom("MontserratRoman-Medium", size: 15))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("", text: $firstName)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                        Text("Last name")
                            .font(Font.custom("MontserratRoman-Medium", size: 15))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("", text: $lastName)
                            .textFieldStyle(.roundedBorder)
                            .autocapitalization(.none)
                        Text("Age")
                            .font(Font.custom("MontserratRoman-Medium", size: 15))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextField("", text: $age)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                    }
                }
                .padding()
                .background(Color("Neutral"))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("Tertiary"), lineWidth: 1.5)
                )
                
                Button(action: { submitPg1() }) {
                    Text("Next")
                        .padding(8)
                        .foregroundColor(Color("Tertiary"))
                        .overlay(
                            Capsule(style: .continuous)
                                .stroke(Color("Tertiary"), lineWidth: 2)
                        )
                }
            }
            .padding()
        }
    }
    
    func submitPg1() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let uid : String = (Auth.auth().currentUser?.uid)!
        ref.child("users/\(uid)/name").updateChildValues(["firstname": firstName, "lastname": lastName])
        ref.child("users/\(uid)").updateChildValues(["age": age])
        self.nextPg = true
    }
}

struct InitQuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        NavQuestionnaireView()
    }
}
