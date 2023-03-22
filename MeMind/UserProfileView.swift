//
//  UserProfileView.swift
//  MeMind
//
//  Created by Puloma Katiyar on 2/21/23.
//

import SwiftUI
import Charts
import Firebase
import FirebaseAuth

struct MoodLog: Identifiable {

    let id = UUID()
    let weekday: Date
    let mood: Int

    init(day: String, mood: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"

        self.weekday = formatter.date(from: day) ?? Date.distantPast
        self.mood = mood
    }
}

let currentWeek: [MoodLog] = [
    MoodLog(day: "20220717", mood: 2),
    MoodLog(day: "20220716", mood: 0),
    MoodLog(day: "20220715", mood: 1),
    MoodLog(day: "20220714", mood: 1),
    MoodLog(day: "20220713", mood: 2),
    MoodLog(day: "20220712", mood: 1),
    MoodLog(day: "20220711", mood: 0)
]


struct UserProfileView: View {
    @State var userEmail = ""
    @State var userName = ""
    @State var userRecentMood = ""
    @State var moodValues = ["Excited": 2, "Happy": 2, "Content": 1, "Neutral": 1, "Sad": 0, "Stressed": 0]
    
    var body: some View {
        ZStack {
            VStack {
                Color("MainBackground").ignoresSafeArea()
            }
            VStack {
                GroupBox ( "Daily Mood - Current Week") {
                    Chart(currentWeek) {
                        LineMark(
                            x: .value("Week Day", $0.weekday, unit: .day),
                            y: .value("Mood", $0.mood)
                        )
                    }
                    .frame(width: 300, height: 80, alignment: .center)
                }
                .padding(10)
                Text("username: \(userEmail)")
                Text("name: \(userName)")
            }
        }
        .onAppear {
            getUserData()
        }
    }
    
    func getUserData() {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let uid = Auth.auth().currentUser?.uid
        
        ref.child("users").child(uid!).observeSingleEvent(of: .value, with: { snapshot in
            if(snapshot.hasChild("username")) {
                userEmail = snapshot.childSnapshot(forPath: "username").value as? String ?? ""
                if(snapshot.hasChild("name")) {
                    userName = snapshot.childSnapshot(forPath: "name").childSnapshot(forPath: "firstname").value as? String ?? ""
                    userName += snapshot.childSnapshot(forPath: "name").childSnapshot(forPath: "lastname").value as? String ?? ""
                }
                if(snapshot.hasChild("moodLogs")) {
                    
                }
            }

//            let value = snapshot.value as? NSDictionary
//            let username = value?["username"] as? String ?? ""

        }) { error in
            print(error.localizedDescription)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
