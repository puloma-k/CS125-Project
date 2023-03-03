//
//  InitQuestionnaire3View.swift
//  MeMind
//
//  Created by Puloma Katiyar on 3/2/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

struct NavQuestionnaire3View: View {
    @State var nextPg = false
    
    var body: some View {
        return Group {
            if nextPg {
                HomeView()
            } else {
                InitQuestionnaire3View(nextPg: $nextPg)
            }
        }
    }
}

struct QuestionPickerGad: View {
    let i: Int
    let q: String
    @State private var score = 0
    
    @Binding var gadScores: Dictionary<String, Int>
    
    var body: some View {
        VStack {
            Text(q)
                .font(Font.custom("MontserratRoman-Medium", size: 15))
                .frame(maxWidth: .infinity, alignment: .leading)
            Picker("text", selection: $score) {
                Text("0").tag(0)
                Text("1").tag(1)
                Text("2").tag(2)
                Text("3").tag(3)
            }
            .pickerStyle(.segmented)
            .onChange(of: score) { _ in
                gadScores["q\(i)"] = score
            }
        }
        .padding()
        .background(Color("Neutral"))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("Tertiary"), lineWidth: 1.5)
        )
    }
}

struct InitQuestionnaire3View: View {
    @State var gadScores = ["q1": 0, "q2": 0, "q3": 0, "q4": 0, "q5": 0, "q6": 0, "q7": 0]
    @State var ques = [
        "Feeling nervous, anxious, or on edge:",
        "Not being able to stop or control worrying:",
        "Worrying too much about different things:",
        "Trouble relaxing:",
        "Being so restless that it’s hard to sit still:",
        "Becoming easily annoyed or irritable:",
        "Feeling afraid as if something awful might happen:"
    ]
    
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
                    Text("Over the last 2 weeks, how often have you been bothered by any of the following problems?")
                        .font(Font.custom("MontserratRoman-Bold", size: 17))
                    Spacer().frame(height:10)
                    Text("0 - Not at all\n1 - Several days\n2 - More than half the days\n3 - Nearly every day")
                        .font(Font.custom("MontserratRoman-Medium", size: 15))
                }
                .padding()
                .background(Color("Neutral"))
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("Tertiary"), lineWidth: 1.5)
                )
                
                VStack {
                    List {
                        ForEach(ques.indices, id: \.self) { i in
                            QuestionPickerGad(i: i, q: ques[i], gadScores: $gadScores)
                                .listRowBackground(Color.clear)
                                .scrollContentBackground(.hidden)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
                
                Button(action: { submitPg3() }) {
                    Text("Submit")
                        .padding(8)
                        .foregroundColor(Color("Tertiary"))
                        .overlay(
                            Capsule(style: .continuous)
                                .stroke(Color("Tertiary"), lineWidth: 2)
                        )
                }
            }
        }
    }

    func submitPg3() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let uid : String = (Auth.auth().currentUser?.uid)!
        ref.child("users").child(uid).child("gadScores").updateChildValues(gadScores)
        self.nextPg = true
    }
}

struct InitQuestionnaire3View_Previews: PreviewProvider {
    static var previews: some View {
        NavQuestionnaire3View()
    }
}
