//
//  ChannelRow.swift
//  RedFMToronto
//
//  Created by Mohit Arora on 2024-04-26.
//

import SwiftUI

struct ChannelRow: View {
    var channel: Channel
    var isPlaying: Bool
    var togglePlay: (Channel) -> Void

    var body: some View {
        HStack {
            Text(channel.name)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(.primary)

            Spacer()

            Button(action: {
                togglePlay(channel)
            }) {
                Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(isPlaying ? .red : .green)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
        .background(background(for: isPlaying)) // Correct usage of background method
        .cornerRadius(10)
    }
    
    // Function to return Color based on playing state
    private func background(for isPlaying: Bool) -> Color {
        return isPlaying ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2)
    }
}
