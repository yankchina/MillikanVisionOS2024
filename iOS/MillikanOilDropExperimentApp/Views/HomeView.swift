//
//  HomeView.swift
//  MillikanOilDropExperimentApp
//
//  Created by Ankang Yang on 2024/6/8.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            HStack {
                Text("AppTitle".localized)
                    .font(.largeTitle)
                    .padding()
                Spacer()
                Image("logo")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding()
            }
            HomeContentView()
                .padding()
            Image("placeholder")
                .resizable()
                .frame(width: 300, height: 200)
                .border(Color.black, width: 1)
            HStack {
                Button("HomeButton1".localized) {
                    // Action for BUTTON1
                }
                .padding()
                Button("HomeButton2".localized) {
                    // Action for BUTTON2
                }
                .padding()
                Button("HomeButton3".localized) {
                    // Action for BUTTON3
                }
                .padding()
            }
        }
    }
}

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
