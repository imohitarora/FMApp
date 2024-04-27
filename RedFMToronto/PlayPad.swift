//
//  PlayPad.swift
//  RedFMToronto
//
//  Created by Mohit Arora on 2024-04-26.
//

import SwiftUI
import AVFoundation

struct PlayPad: View {
    @StateObject var audioPlayer = AudioPlayer()
    
    @ObservedObject var channelManager = ChannelManager.shared // Add this line
    
    @State private var currentPlayer: Channel?
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 1) {
                    ForEach(channelManager.channels, id: \.self) { channel in
                        ChannelRow(channel: channel, isPlaying: channelManager.playingChannels[channel, default: false], togglePlay: togglePlay)
                            .padding(.vertical, 5)
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
                .background(Color(UIColor.systemGroupedBackground)) // Adapt to light/dark mode
            }
            .navigationTitle("Radio Channels")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
    
    private func togglePlay(for channel: Channel) {
        if channelManager.playingChannels[channel, default: false] {
            channelManager.stopPlayback()
        } else {
            if let index = channelManager.channels.firstIndex(of: channel) {
                channelManager.currentChannelIndex = index
            }
            channelManager.startPlayback(for: channel)
        }
    }
    
    private func nextChannel() {
        channelManager.nextChannel()
    }
    
    private func previousChannel() {
        channelManager.previousChannel()
    }
}

#Preview {
    PlayPad()
}
