//
//  RecommendedActivityView.swift
//  MeMind
//
//  Created by Puloma Katiyar on 2/21/23.
//

import SwiftUI

struct RecommendedActivityView: View {
    @State var title: String
    @State var url: String
    @State var thumbnail: String
    
    var body: some View {
        VStack{
            Text("\(title)")
                .font(Font.custom("AlegreyaRoman-Medium", size: 20))
            AsyncImage(url: URL(string: "\(thumbnail)")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 100)
            Link("Go to activity", destination: URL(string: "\(url)")!)
        }
        .frame(width: 300)
        .padding()
        .background(Color("Mood3"))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color("Tertiary"), lineWidth: 1.5)
        )
    }
}

//struct RecommendedActivityView_Previews: PreviewProvider {
//    static var previews: some View {
//        RecommendedActivityView(color: "Mood3")
//    }
//}
