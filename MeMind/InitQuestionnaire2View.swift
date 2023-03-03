//
//  InitQuestionnaireView.swift
//  MeMind
//
//  Created by Puloma Katiyar on 3/2/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

struct NavQuestionnaire2View: View {
    @State var nextPg = false
    
    var body: some View {
        return Group {
            if nextPg {
                NavQuestionnaire3View()
            } else {
                InitQuestionnaire2View(nextPg: $nextPg)
            }
        }
    }
}

struct QuestionPickerPhq: View {
    let i: Int
    let q: String
    @State private var score = 0
    
    @Binding var phqScores: Dictionary<String, Int>
    
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
                phqScores["q\(i)"] = score
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

struct InitQuestionnaire2View: View {
    @State var phqScores = ["q1": 0, "q2": 0, "q3": 0, "q4": 0, "q5": 0, "q6": 0, "q7": 0, "q8": 0, "q9": 0]
    @State var ques = [
        "Little interest or pleasure in doing things:",
        "Feeling down, depressed, or hopeless:",
        "Trouble falling or staying asleep, or sleeping too much:",
        "Feeling tired or having little energy:",
        "Poor appetite or overeating:",
        "Feeling bad about yourself – or that you are a failure or have let yourself or your family down:",
        "Trouble concentrating on things, such as reading the newspaper or watching television:",
        "Moving or speaking so slowly that other people could have noticed. Or the opposite – being so fidgety or restless that you have been moving around a lot more than usual:",
        "Thoughts that you would be better off dead, or of hurting yourself in some way:"
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
                            QuestionPickerPhq(i: i, q: ques[i], phqScores: $phqScores)
                                .listRowBackground(Color.clear)
                                .scrollContentBackground(.hidden)
                        }
                    }
                    .listStyle(PlainListStyle())
                }

                Button(action: { submitPg2() }) {
                    Text("Next")
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

    func submitPg2() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let uid : String = (Auth.auth().currentUser?.uid)!
        ref.child("users").child(uid).child("phqScores").updateChildValues(phqScores)
        self.nextPg = true
    }
}

struct InitQuestionnaire2View_Previews: PreviewProvider {
    static var previews: some View {
        NavQuestionnaire2View()
    }
}
