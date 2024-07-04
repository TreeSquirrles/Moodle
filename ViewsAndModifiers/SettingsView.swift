//
//  SettingsView.swift
//  ViewsAndModifiers
//
//  Created by Seungyoo Kim-Jung on 7/4/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack{
            VStack {
                Exit()
                
                Text("CREDITS")
                    .title()
                    .padding()
                
                
                Image("MoodleCircle")
                    .imageScale(.small)
                
                HStack{
                    VStack{
                        Text("About us")
                            .font(.title)
                            .fontDesign(.rounded)
                            .fontWeight(.heavy)
                        Text("This is one paragraph that I wrote by myself. It has nothing to do with what Moodle is about but it is a paragraph so it is okay. This paragraph will be replaced by a real one once we know what to write. This will be repeated on the other side.")
                            .padding([.top, .bottom], 0.4)
                        Text("This is the second paragraph we will use. It will help us to write a bunch of stuff with really nice spacing and all that good stuff. It will make everything look really good and that is what we want. Moodle needs to look good, after all.")
                            .padding([.top, .bottom], 0.4)
                        Text("Don't worry, we'll have many subtitles for all the other people around. It'll be really cool. :)")
                            .padding([.top], 0.4)
                    }
                    VStack{
                        Image("Divider")
                    }
                    VStack{
                        Text("Our mission")
                            .font(.title)
                            .fontDesign(.rounded)
                            .fontWeight(.heavy)
                        Text("\nThis is one paragraph that I wrote by myself. It has nothing to do with what Moodle is about but it is a paragraph so it is okay. This paragraph will be replaced by a real one once we know what to write. This will be repeated on the other side.\n\n")
                            .padding([.top, .bottom], 0.4)
                        Text("This is the second paragraph we will use. It will help us to write a bunch of stuff with really nice spacing and all that good stuff. It will make everything look really good and that is what we want. Moodle needs to look good, after all.\n\n")
                            .padding([.top, .bottom], 0.4)
                        Text("Don't worry, we'll have many subtitles for all the other people around. It'll be really cool. :)")
                            .padding([.top], 0.4)
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    SettingsView()
}
