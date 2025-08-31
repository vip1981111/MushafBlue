//
//  QuranMeta.swift
//  MushafBlue
//
//  Created by MOHAMMED ABDULLAH on 22/08/2025.
//

import Foundation

enum QuranMeta {
static let surahNames: [String] = {
    guard let url = Bundle.main.url(forResource: "surah-names-ar", withExtension: "txt"),
          let content = try? String(contentsOf: url, encoding: .utf8) else {
        return []
    }
    return content
        .components(separatedBy: .newlines)
        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        .filter { !$0.isEmpty }
}()
}
