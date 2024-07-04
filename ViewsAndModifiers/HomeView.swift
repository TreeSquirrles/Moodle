//
//  HomeView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/4/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Image("Moodle")
            
            Text("MOODLE")
                .title()
            
            Spacer()
            
            //            Button("Cards") {
            //                // more code to come
            //            }
            //                .button()
            //            Button("Decks/Study") {
            //                // more code to come
            //            }
            //                .button()
            //            Button("Credits") {
            //                // showCredits no longer exists
            //            }
            //            .button()
        }
    }
}

#Preview {
    HomeView()
}
