//
//  RecommendedActivitiesView.swift
//  MeMind
//
//  Created by Puloma Katiyar on 2/21/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct RecData: Identifiable {
    var id: Int
    var title: String
    var url: String
    var thumbnail: String
    var recommended: Bool
}

struct RecommendedActivitiesView: View {
    @EnvironmentObject var moodLogged: Logged
    @State var recs = [RecData]()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Recommended for you")
                    .font(Font.custom("AlegreyaRoman-Medium", size: 35))
                if !moodLogged.isLogged {
                    VStack {
                        Text("You haven't logged your mood today!")
                            .font(Font.custom("MontserratRoman-Medium", size: 20))
                            .multilineTextAlignment(.center)
                        Spacer().frame(height: 10)
                        Text("Go to the mood tracker tab to enter your mood")
                            .font(Font.custom("MontserratRoman-Medium", size: 15))
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("MainBackground"))
                }
                Spacer().frame(height: 10)
                  
                ScrollView(.vertical) {
                    VStack {
                        ForEach(recs) { rec in
                            RecommendedActivityView(title: rec.title, url: rec.url, thumbnail: rec.thumbnail)
                            Spacer().frame(height: 15)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear{
            getUserRecommendations()
        }
    }
    
    func getUserRecommendations(){
        // Prepare URL
        let url = URL(string: "http://node-express-env.eba-mxjk9php.us-west-1.elasticbeanstalk.com/activities")
        guard let requestUrl = url else { fatalError() }

        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
         
        // HTTP Request Parameters which will be sent in HTTP Request Body
        let postString = "username=test@test.com"
        print(postString)

        // Set HTTP Request Body
        request.httpBody = postString.data(using: String.Encoding.utf8);

        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
//                print("Response data string:\n \(dataString)")
                do {
                    if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                    {
                        
                        for (i, val) in jsonArray.enumerated() {
                            recs.append(RecData(id: i, title: val["title"] as! String, url: val["url"] as! String, thumbnail: val["thumbnail"] as! String, recommended: val["recommended"] as! Bool))
                        }
                    } else {
                        print("bad json")
                    }
                } catch let error as NSError {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
}

//struct RecommendedActivitiesView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecommendedActivitiesView()
//    }
//}
