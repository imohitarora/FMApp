//
//  ChannelManager.swift
//  RedFMToronto
//
//  Created by Mohit Arora on 2024-04-26.
//

import Foundation
import AVFoundation


class ChannelManager: ObservableObject {
    static let shared = ChannelManager()
    
    var audioPlayer = AudioPlayer()
    var currentPlayer: Channel?
    
    var channels: [Channel] = [
        Channel(name: "RED FM Toronto", url: URL(string: "https://ice9.securenetsystems.net/CIRVFM")!),
        Channel(name: "RED FM Mumbai", url: URL(string: "https://funasia.streamguys1.com/live9")!),
        Channel(name: "Radio City Mumbai", url: URL(string: "https://prclive4.listenon.in/Hindi")!),
        Channel(name: "Vividh Bharti", url: URL(string: "https://air.pc.cdn.bitgravity.com/air/live/pbaudio001/playlist.m3u8")!),
        Channel(name: "AIR - Suratgarh", url: URL(string: "https://air.pc.cdn.bitgravity.com/air/live/pbaudio064/chunklist.m3u8")!),
        Channel(name: "Ishq FM", url: URL(string: "https://prclive4.listenon.in/Ishq")!),
        Channel(name: "Punjabi FM", url: URL(string: "https://prclive4.listenon.in/Punjabi")!),
        Channel(name: "Brit Asia", url: URL(string: "https://s4.radio.co/sfefce156f/listen")!),
        Channel(name: "CRIF Brampton", url: URL(string: "https://ice66.securenetsystems.net/CIRF")!),
        Channel(name: "CMR Toronto", url: URL(string: "https://live.cmr24.net/CMR/Punjabi-MQ/icecast.audio")!),
        Channel(name: "Jaipur Radio", url: URL(string: "https://streamasiacdn.atc-labs.com/jaipurradio.aac")!)
    ]
    
    @Published var playingChannels: [Channel: Bool] = [:]
    @Published var currentChannelIndex = -1 {
        didSet {
            if currentChannelIndex != -1 {
                playingChannels[channels[currentChannelIndex]] = true
            }
        }
    }
    
    func startPlayback(for channel: Channel) {
        print("Starting playback for channel: \(channel.name)")
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
    
    func stopPlayback() {
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
    
    func nextChannel() {
        currentChannelIndex = (currentChannelIndex + 1) % channels.count
        startPlayback(for: channels[currentChannelIndex])
    }

    func previousChannel() {
        currentChannelIndex = (currentChannelIndex - 1 + channels.count) % channels.count
        startPlayback(for: channels[currentChannelIndex])
    }
}
