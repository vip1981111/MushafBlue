//
//  QuranLoader.swift
//  MushafBlue
//
//  Created by MOHAMMED ABDULLAH on 21/08/2025.
//

import Foundation

final class QuranLoader {
    static let shared = QuranLoader()
private(set) var versesBySura: [Int: [Verse]] = [:]
private(set) var allVerses: [Verse] = []

init() {
    load()
}

private func load() {
    guard let url = Bundle.main.url(forResource: "quran-uthmani", withExtension: "txt"),
          let content = try? String(contentsOf: url, encoding: .utf8) else {
        print("quran-uthmani.txt not found")
        return
    }

    var dict: [Int: [Verse]] = [:]

    for line in content.split(whereSeparator: \.isNewline) {
        // صيغة Tanzil: sura|ayah|text
        let parts = line.split(separator: "|", maxSplits: 2, omittingEmptySubsequences: false)
        guard parts.count == 3,
              let s = Int(parts[0]),
              let a = Int(parts[1]) else { continue }
        let t = String(parts[2])
        let v = Verse(sura: s, aya: a, text: t)
        dict[s, default: []].append(v)
    }

    // ترتيب الآيات داخل كل سورة
    for (k, arr) in dict {
        dict[k] = arr.sorted { $0.aya < $1.aya }
    }

    // احفظ القاموس
    self.versesBySura = dict

    // حوّل القاموس إلى مصفوفة واحدة مرتبة سوراً ثم آيات
    self.allVerses = (1...114).flatMap { dict[$0] ?? [] }
    // بديل مكافئ:
    // self.allVerses = Array(dict.keys.sorted()).flatMap { dict[$0]! }
    // أو:
    // self.allVerses = Array(dict.values.joined())
}
}
