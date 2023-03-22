//
//  RecommendedActivitiesView.swift
//  MeMind
//
//  Created by Puloma Katiyar on 2/21/23.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct RecommendedActivitiesView: View {
    @State var userEmail = ""
    @State var userName = ""
    
    var body: some View {
        VStack{
            Text("\(userEmail)")
                .font(Font.custom("AlegreyaRoman-Medium", size: 35))
            ForEach((1...3), id: \.self) {_ in
                RecommendedActivityView()
                    .padding(10)
            }
        }
        .onAppear{
            getUserRecommendations()
        }
        
    }
    
    func getUserRecommendations() {
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
                    print("Response data string:\n \(dataString)")
                }
        }
        task.resume()
    }
    
}

struct RecommendedActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedActivitiesView()
    }
}
