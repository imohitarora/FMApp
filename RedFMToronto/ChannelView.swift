//
//  ChannelView.swift
//  RedFMToronto
//
//  Created by Mohit Arora on 2024-04-26.
//

import SwiftUI

struct ChannelView: View {
    @State private var channels: [Channel] = [
        Channel(name: "RED FM Toronto", url: URL(string: "https://ice9.securenetsystems.net/CIRVFM")!),
        Channel(name: "RED FM Calgary", url: URL(string: "https://ice9.securenetsystems.net/CIRVFM")!),
        Channel(name: "RED FM Mumbai", url: URL(string: "https://ice9.securenetsystems.net/CIRVFM")!),
        // Add more channels here
    ]

    var body: some View {
        List(channels) { channel in
            VStack(alignment: .leading) {
                HStack {
                    Text(channel.name)
                        .font(.headline)
                    Spacer()
                    PlayView()
                }
            }
        }
    }
}

#Preview {
    ChannelView()
}
