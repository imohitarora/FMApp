//
//  PlayView.swift
//  RedFMToronto
//
//  Created by Mohit Arora on 2024-04-26.
//

import SwiftUI
import AVFoundation

struct PlayView: View {
    
    @State private var channels: [Channel] = [
        Channel(name: "RED FM Toronto", url: URL(string: "https://ice9.securenetsystems.net/CIRVFM")!),
        Channel(name: "RED FM Calgary", url: URL(string: "https://ice10.securenetsystems.net/CKYR")!),
        Channel(name: "RED FM Mumbai", url: URL(string: "https://funasia.streamguys1.com/live9")!),
        Channel(name: "Radio City Mumbai", url: URL(string: "https://prclive4.listenon.in/Hindi")!),
        Channel(name: "Vividh Bharti - 100.1", url: URL(string: "https://air.pc.cdn.bitgravity.com/air/live/pbaudio001/playlist.m3u8")!),
        // Add more channels here
    ]
    
    @State private var playingChannels: [Channel: Bool] = [:]
    
    @State private var currentPlayer: Channel?
    
    @State private var player = AVPlayer()
    
    
    var body: some View {
        NavigationView {
            List(channels, id: \.self) { channel in
                VStack(alignment: .leading) {
                    HStack {
                        Text(channel.name)
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: playingChannels[channel, default: false] ? "pause.circle.fill" : "play.circle.fill")
                            .foregroundColor(playingChannels[channel, default: false] ? .red : .green)
                            .background(Circle()
                                .fill(Color.white)
                                .shadow(radius: 2)
                            )
                    }
                    .onTapGesture {
                        if playingChannels[channel, default: false] {
                            player.pause()
                            playingChannels[channel] = false
                        } else {
                            if let currentChannel = currentPlayer {
                                player.pause()
                                playingChannels[currentChannel] = false
                            }
                            playAudio(for: channel)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                }
                .listStyle(.plain)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Radio Channels")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func playAudio(for channel: Channel) {
        let playerItem = AVPlayerItem(url: channel.url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        playingChannels[channel] = true
        currentPlayer = channel
    }
}


#Preview {
    PlayView()
}
