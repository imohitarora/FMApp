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
                .fontWeight(.bold)
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
    }
}

//#Preview {
//    ChannelRow()
//}
