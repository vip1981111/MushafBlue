//
//  SurahListView.swift
//  MushafBlue
//
//  Created by MOHAMMED ABDULLAH on 21/08/2025.
//

import SwiftUI

struct SurahListView: View {
    let suraCount = 114
    @State private var last: (sura: Int, aya: Int)?
private func name(for sura: Int) -> String {
    if QuranMeta.surahNames.indices.contains(sura - 1) {
        return QuranMeta.surahNames[sura - 1]
    } else {
        return "سورة رقم \(sura)"
    }
}

var body: some View {
    NavigationStack {
        List {
            if let last {
                Section {
                    NavigationLink("متابعة القراءة: \(name(for: last.sura)) • آية \(last.aya)") {
                        SurahView(sura: last.sura, focusAya: last.aya)
                    }
                }
            }
            Section(header: Text("الفهرس")) {
                ForEach(1...suraCount, id: \.self) { s in
                    NavigationLink("\(name(for: s))") {
                        SurahView(sura: s)
                    }
                }
            }
        }
        .navigationTitle("المصحف")
        .onAppear { last = ReadingState.shared.load() }
        .toolbar {
            HStack {
                NavigationLink(destination: SearchView()) { Image(systemName: "magnifyingglass") }
                NavigationLink(destination: BookmarksView()) { Image(systemName: "star") }
                NavigationLink(destination: AboutView()) { Image(systemName: "info.circle") }
            }
        }
    }
}
}
