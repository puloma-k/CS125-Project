//
//  RecommendedActivitiesView.swift
//  MeMind
//
//  Created by Puloma Katiyar on 2/21/23.
//

import SwiftUI

struct RecommendedActivitiesView: View {
    
    var body: some View {
        VStack{
            Text("Recommendations")
                .font(Font.custom("AlegreyaRoman-Medium", size: 35))
            ForEach((1...3), id: \.self) {_ in
                RecommendedActivityView()
                    .padding(10)
            }
        }
        
        
    }
}

struct RecommendedActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedActivitiesView()
    }
}
