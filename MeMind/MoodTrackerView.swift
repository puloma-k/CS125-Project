//
//  MoodTrackerView.swift
//  MeMind
//
//  Created by Puloma Katiyar on 2/21/23.
//

import SwiftUI

struct MoodTrackerView: View {
    var body: some View {
        Text(getDate())
            .font(Font.custom("AlegreyaRoman-Medium", size: 30))
        
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
