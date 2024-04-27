//
//  ChannelManager.swift
//  RedFMToronto
//
//  Created by Mohit Arora on 2024-04-26.
//

import Foundation


class ChannelManager: ObservableObject {
    static let shared = ChannelManager()
    
    var channels: [Channel] = [
        Channel(name: "RED FM Toronto", url: URL(string: "https://ice9.securenetsystems.net/CIRVFM")!),
        Channel(name: "RED FM Calgary", url: URL(string: "https://ice10.securenetsystems.net/CKYR")!),
        Channel(name: "RED FM Mumbai", url: URL(string: "https://funasia.streamguys1.com/live9")!),
        Channel(name: "Radio City Mumbai", url: URL(string: "https://prclive4.listenon.in/Hindi")!),
        Channel(name: "Vividh Bharti - 100.1", url: URL(string: "https://air.pc.cdn.bitgravity.com/air/live/pbaudio001/playlist.m3u8")!)
    ]
    
    @Published var currentChannelIndex = 0
    
    func nextChannel() {
        if currentChannelIndex < channels.count - 1 {
            currentChannelIndex += 1
        } else {
            currentChannelIndex = 0
        }
    }

    func previousChannel() {
        if currentChannelIndex > 0 {
            currentChannelIndex -= 1
        } else {
            currentChannelIndex = channels.count - 1
        }
    }
}
