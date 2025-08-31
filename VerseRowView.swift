//
//  VerseRowView.swift
//  MushafBlue
//
//  Created by MOHAMMED ABDULLAH on 22/08/2025.
//

import SwiftUI

struct VerseRowView: View {
    let verse: Verse
    let isPlaying: Bool
    let onTogglePlay: () -> Void
    let onToggleBookmark: () -> Void
    let isBookmarked: Bool
var body: some View {
    let keyColor = isPlaying ? Color.yellow.opacity(0.2) : Color.clear

    HStack(alignment: .firstTextBaseline, spacing: 12) {
        // تشغيل/إيقاف
        Button(action: onTogglePlay) {
            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .font(.title2)
        }

        // نجمة
        Button(action: onToggleBookmark) {
            Image(systemName: isBookmarked ? "star.fill" : "star")
                .foregroundColor(.yellow)
                .font(.title3)
        }

        // نص الآية + رقمها
        HStack(spacing: 6) {
            Text(verse.text)
                .multilineTextAlignment(.trailing)
            Text(ayahBadge(verse.aya)) // ﴿١﴾ … ﴿٢﴾
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    .padding(.horizontal)
    .background(keyColor)
}
}
