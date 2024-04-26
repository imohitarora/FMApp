//
//  PlayView.swift
//  RedFMToronto
//
//  Created by Mohit Arora on 2024-04-26.
//

import SwiftUI

struct PlayView: View {
    @State var play = true
    var body: some View {
        VStack {
            Image(systemName: play ? "play.circle" : "stop.circle")                
                .onTapGesture {
                    play.toggle()
                }
        }
    }
}

#Preview {
    PlayView()
}
