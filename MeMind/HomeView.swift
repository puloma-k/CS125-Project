//
//  HomeView.swift
//  MeMind
//
//  Created by Puloma Katiyar on 2/21/23.
//

import SwiftUI

struct HomeView: View {
    @State private var selection: Tab = .activities

    enum Tab {
        case moodTracker
        case mindfulness
        case userProfile
        case activities
    }
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "MainBackground")
    }
    
    var body: some View {
        TabView(selection: $selection) {
            RecommendedActivitiesView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.activities)

            MoodTrackerView()
                .tabItem {
                    Label("Mood Tracker", systemImage: "square.and.pencil")
                }
                .tag(Tab.moodTracker)
            
//            MindfulnessView()
//                .tabItem {
//                    Label("Mindfulness", systemImage: "list.bullet")
//                }
//                .tag(Tab.mindfulness)
            
            UserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(Tab.userProfile)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
