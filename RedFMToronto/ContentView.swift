//
//  ContentView.swift
//  RedFMToronto
//
//  Created by Mohit Arora on 2024-04-26.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject var audioPlayer: AudioPlayer

    var body: some View {
        PlayPad(audioPlayer: audioPlayer)
    }
}

#Preview {
    ContentView(audioPlayer: AudioPlayer())
}
