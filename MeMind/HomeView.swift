//
//  HomeView.swift
//  MeMind
//
//  Created by Puloma Katiyar on 2/21/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct HomeView: View {
    @StateObject var locationManager = LocationManager()
    @State private var selection: Tab = .activities

    enum Tab {
        case moodTracker
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

            UserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(Tab.userProfile)
        }
        .onAppear {
            getLocation()
        }
    }
    
    func getLocation() {
        var latitude = ""
        var longitude = ""
        switch locationManager.locationManager.authorizationStatus {
            case .authorizedWhenInUse:
                latitude = locationManager.locationManager.location?.coordinate.latitude.description ?? ""
                longitude = locationManager.locationManager.location?.coordinate.longitude.description ?? ""
            default:
                break
        }
        
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let uid : String = (Auth.auth().currentUser?.uid)!
        ref.child("users/\(uid)/location").updateChildValues(["latitude": latitude, "longitude": longitude])
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
