//
//  PlayerView.swift
//  RedFMToronto
//
//  Created by Mohit Arora on 2024-04-26.
//

import SwiftUI
import AVFoundation

struct PlayerView: View {
    let channel: Channel
    @State private var player = AVPlayer()

    var body: some View {
        VStack {
            Text(channel.name)
                .font(.title)
            Text("Now playing...")
                .font(.subheadline)
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
        let playerItem = AVPlayerItem(url: channel.url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
}

#Preview {
    PlayerView(channel: Channel(name: "CIRV FM", url: URL(string: "https://ice9.securenetsystems.net/CIRVFM")!))
}
