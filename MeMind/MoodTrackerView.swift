//
//  MoodTrackerView.swift
//  MeMind
//
//  Created by Puloma Katiyar on 2/21/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct MoodTrackerView: View {
    @State var noMoodError = false
    @State var duplicateEntryError = false
    @State var submitSuccess = false
    @State var curMood = ""
    @State var userReflection = ""
    @State var moods = ["Excited", "Happy", "Content", "Neutral", "Sad", "Stressed"]
    @State var curDate: String
    
    init() {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        curDate = df.string(from: date)
    }
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Text("Daily Mood Log")
                        .font(Font.custom("AlegreyaRoman-Medium", size: 35))
                    Text(getDate())
                        .font(Font.custom("AlegreyaRoman-Medium", size: 25))
                    
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(1...6, id: \.self) { i in
                                Group {
                                    VStack {
                                        Button(action: { curMood = moods[i-1] }) {
                                            Image("emotion\(i)")
                                                .resizable()
                                                .frame(width: 60, height: 60)
                                                .padding()
                                                .background(Color("Mood\(i)"))
                                                .clipShape(Circle())
                                        }
                                        Text(moods[i-1])
                                            .font(Font.custom("MontserratRoman-Medium", size: 15))
                                    }
                                }
                            }
                        }
                    }
                    .frame(height: 100)
                    .padding()
                    Spacer().frame(height: 20)
                    Text("Your mood for today is: **\(curMood)**")
                        .font(Font.custom("MontserratRoman-Medium", size: 17))
                }
                Spacer().frame(height: 20)
                
                VStack {
                    Text("Daily Reflection")
                        .font(Font.custom("MontserratRoman-Medium", size: 20))
                    Spacer().frame(height: 10)
                    Text("How are you feeling today?")
                        .font(Font.custom("AlegreyaRoman-Medium", size: 30))
                    HStack {
                        VStack {
                            TextField("", text: $userReflection, axis: .vertical)
                                .lineLimit(2...10)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .textFieldStyle(.roundedBorder)
                                .cornerRadius(15)
                                .shadow(radius: 0.25)
                        }
                        
                        Button(action: { submitMoodLog() }) {
                            Image(systemName: "paperplane")
                                .foregroundColor(Color("Tertiary"))
                        }
                        .alert(
                            "Please select a mood.",
                            isPresented: $noMoodError
                        ) {}
                        .alert(
                            "Mood already logged for today.",
                            isPresented: $duplicateEntryError
                        ) {}
                        .alert(
                            "Successfully logged today's mood!",
                            isPresented: $submitSuccess
                        ) {}
                    }
                }
                .padding()
                .background(Color("MainBackground"))

            }
        }
    }

    func submitMoodLog() {
        if(self.curMood == "") {
            self.noMoodError = true
        }
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let uid : String = (Auth.auth().currentUser?.uid)!
        ref.child("users/\(uid)/moodLogs").observeSingleEvent(of: .value, with: { snapshot in
            if(snapshot.hasChild("\(curDate)")) {
                self.duplicateEntryError = true
            } else {
                ref.child("users/\(uid)/moodLogs/\(curDate)").updateChildValues(["mood": curMood, "reflection": userReflection])
                self.submitSuccess = true
            }
        })
    }
    
    func getDate() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMMM d, yyyy"
        return df.string(from: date)
    }
}

struct MoodTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        MoodTrackerView()
    }
}
