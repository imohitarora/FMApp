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
    
    
    @State private var playingChannels: [Channel: Bool] = [:]
    @State private var currentPlayer: Channel?
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 1) {
                    ForEach(channelManager.channels, id: \.self) { channel in
                        ChannelRow(channel: channel, isPlaying: channelManager.currentChannelIndex == channelManager.channels.firstIndex(of: channel), togglePlay: togglePlay)
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
        audioPlayer.replaceCurrentItem(with: playerItem)
        audioPlayer.play()
        playingChannels[channel] = true
        currentPlayer = channel
        
        // Add the following lines to start playback in background
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error setting up audio session: \(error)")
        }
    }
    
    private func stopPlayback() {
        audioPlayer.pause()
        if let currentChannel = currentPlayer {
            playingChannels[currentChannel] = false
        }
        
        // Add the following lines to stop playback in background
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch {
            print("Error stopping audio session: \(error)")
        }
    }
    
    private func nextChannel() {
        channelManager.nextChannel()
        startPlayback(for: channelManager.channels[channelManager.currentChannelIndex])
    }
    
    private func previousChannel() {
        channelManager.previousChannel()
        startPlayback(for: channelManager.channels[channelManager.currentChannelIndex])
    }
}

#Preview {
    PlayPad()
}
