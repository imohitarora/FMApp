//
//  ContentView.swift
//  RedFMToronto
//
//  Created by Mohit Arora on 2024-04-26.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var player = AVPlayer()

    var body: some View {
        VStack {
            Button("Play") {
                playAudio()
            }
            Button("Stop") {
                player.pause()
            }
        }
        .padding()
        .onAppear {
            playAudio()
        }
    }

    func playAudio() {
        let url = URL(string: "https://ice9.securenetsystems.net/CIRVFM")!
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
//        player.play()
    }
}

#Preview {
    ContentView()
}
