//
//  SurahView.swift
//  MushafBlue
//
//  Created by MOHAMMED ABDULLAH on 21/08/2025.
//


import SwiftUI
struct SurahView: View {
    let sura: Int
    var focusAya: Int? = nil
@State private var verses: [Verse] = []
@StateObject private var audio = AudioService.shared
@StateObject private var bookmarks = BookmarkStore.shared

var body: some View {
    ScrollViewReader { proxy in
        ScrollView {
            LazyVStack(alignment: .trailing, spacing: 12) {
                ForEach(verses) { v in
                    let key = "\(v.sura)-\(v.aya)"
                    VerseRowView(
                        verse: v,
                        isPlaying: audio.currentlyPlayingKey == key,
                        onTogglePlay: {
                            audio.toggle(sura: v.sura, aya: v.aya)
                            ReadingState.shared.save(sura: v.sura, aya: v.aya)
                        },
                        onToggleBookmark: {
                            bookmarks.toggle(sura: v.sura, aya: v.aya, text: v.text)
                        },
                        isBookmarked: bookmarks.isBookmarked(sura: v.sura, aya: v.aya)
                    )
                    .id(key)
                }
            }
            .padding(.vertical)
        }
        .onChange(of: audio.currentlyPlayingKey) { _, newKey in
            if let k = newKey {
                withAnimation { proxy.scrollTo(k, anchor: .center) }
            }
        }
    }
    .onAppear {
        verses = QuranLoader.shared.versesBySura[sura] ?? []
        print("Verses in sura \(sura) =", verses.count)

        audio.onItemFinished = { finishedSura, finishedAya in
            guard finishedSura == sura,
                  let idx = verses.firstIndex(where: { $0.sura == finishedSura && $0.aya == finishedAya }),
                  idx + 1 < verses.count else { return }
            let next = verses[idx + 1]
            audio.play(sura: next.sura, aya: next.aya)
        }
    }
    .navigationTitle("سورة \(sura)")
    .toolbarTitleDisplayMode(.inline)
}
}
