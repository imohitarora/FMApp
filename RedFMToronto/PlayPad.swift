//
//  PlayPad.swift
//  RedFMToronto
//
//  Created by Mohit Arora on 2024-04-26.
//

import SwiftUI
import AVFoundation

struct PlayPad: View {
    @State private var channels: [Channel] = [
        Channel(name: "RED FM Toronto", url: URL(string: "https://ice9.securenetsystems.net/CIRVFM")!),
        Channel(name: "RED FM Calgary", url: URL(string: "https://ice10.securenetsystems.net/CKYR")!),
        Channel(name: "RED FM Mumbai", url: URL(string: "https://funasia.streamguys1.com/live9")!),
        Channel(name: "Radio City Mumbai", url: URL(string: "https://prclive4.listenon.in/Hindi")!),
        Channel(name: "Vividh Bharti - 100.1", url: URL(string: "https://air.pc.cdn.bitgravity.com/air/live/pbaudio001/playlist.m3u8")!)
    ]
    
    @State private var playingChannels: [Channel: Bool] = [:]
    @State private var currentPlayer: Channel?
    @State private var player = AVPlayer()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(channels, id: \.self) { channel in
                        ChannelRow(channel: channel, isPlaying: playingChannels[channel, default: false], togglePlay: togglePlay)
                            .padding(.vertical, 4)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Radio Channels")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func togglePlay(for channel: Channel) {
        if playingChannels[channel, default: false] {
            stopPlayback()
        } else {
            startPlayback(for: channel)
        }
    }
    
    private func startPlayback(for channel: Channel) {
        if let currentChannel = currentPlayer {
            playingChannels[currentChannel] = false
        }
        let playerItem = AVPlayerItem(url: channel.url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        playingChannels[channel] = true
        currentPlayer = channel
    }
    
    private func stopPlayback() {
        player.pause()
        if let currentChannel = currentPlayer {
            playingChannels[currentChannel] = false
        }
    }
}

#Preview {
    PlayPad()
}
