//
//  RedFMTorontoApp.swift
//  RedFMToronto
//
//  Created by Mohit Arora on 2024-04-26.
//

import SwiftUI
import MediaPlayer

@main
struct RedFMTorontoApp: App {
    @StateObject var audioPlayer = AudioPlayer()
    let channelManager = ChannelManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView(audioPlayer: audioPlayer)
                .onAppear {
                    // Configure audio session for background playback
                    do {
                        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                        try AVAudioSession.sharedInstance().setActive(true)
                    } catch {
                        print("Error setting up audio session: \(error)")
                    }
                    
                    // Update the now-playing information
                    let nowPlayingInfo = MPNowPlayingInfoCenter.default()
                    nowPlayingInfo.nowPlayingInfo = [
                        MPMediaItemPropertyTitle: "Song Title",
                        MPMediaItemPropertyArtist: "Artist Name",
                        MPNowPlayingInfoPropertyPlaybackRate: 1.0
                    ]
                    
                    // Handle remote commands
                    let commandCenter = MPRemoteCommandCenter.shared()
                    commandCenter.playCommand.addTarget { _ in
                        audioPlayer.play()
                        return .success
                    }
                    commandCenter.pauseCommand.addTarget { _ in
                        audioPlayer.pause()
                        return .success
                    }
                    commandCenter.previousTrackCommand.addTarget { _ in
                        channelManager.previousChannel()
                        let currentChannel = channelManager.channels[channelManager.currentChannelIndex]
                        let playerItem = AVPlayerItem(url: currentChannel.url)
                        audioPlayer.replaceCurrentItem(with: playerItem)
                        audioPlayer.play()
                        return .success
                    }
                    commandCenter.nextTrackCommand.addTarget { _ in
                        channelManager.nextChannel()
                        let currentChannel = channelManager.channels[channelManager.currentChannelIndex]
                        let playerItem = AVPlayerItem(url: currentChannel.url)
                        audioPlayer.replaceCurrentItem(with: playerItem)
                        audioPlayer.play()
                        return .success
                    }
                }
        }
    }
}

