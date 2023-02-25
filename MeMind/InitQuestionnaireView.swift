//
//  InitQuestionnaireView.swift
//  MeMind
//
//  Created by Puloma Katiyar on 2/24/23.
//

import SwiftUI

struct InitQuestionnaireView: View {
    var body: some View {
        VStack {
            Text("Welcome to MeMind!").font(.largeTitle).padding()
            Text("Please answer some questions to get started")
        }
    }
}

struct InitQuestionnaireView_Previews: PreviewProvider {
    static var previews: some View {
        InitQuestionnaireView()
    }
}
