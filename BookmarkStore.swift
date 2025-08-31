//
//  BookmarkStore.swift
//  MushafBlue
//
//  Created by MOHAMMED ABDULLAH on 22/08/2025.
//

import Foundation

struct Bookmark: Identifiable, Codable {
    let id: UUID
    let sura: Int
    let aya: Int
    let text: String
    let date: Date
init(sura: Int, aya: Int, text: String, date: Date = Date()) {
    self.id = UUID()
    self.sura = sura
    self.aya = aya
    self.text = text
    self.date = date
}
}

final class BookmarkStore: ObservableObject {
    static let shared = BookmarkStore()
    @Published private(set) var items: [Bookmark] = []
    private let key = "bookmarks"
private init() { load() }

func isBookmarked(sura: Int, aya: Int) -> Bool {
    items.contains { $0.sura == sura && $0.aya == aya }
}

func toggle(sura: Int, aya: Int, text: String) {
    if let idx = items.firstIndex(where: { $0.sura == sura && $0.aya == aya }) {
        items.remove(at: idx)
    } else {
        items.insert(Bookmark(sura: sura, aya: aya, text: text), at: 0)
    }
    save()
}

private func save() {
    if let data = try? JSONEncoder().encode(items) {
        UserDefaults.standard.set(data, forKey: key)
    }
}

private func load() {
    if let data = UserDefaults.standard.data(forKey: key),
       let arr = try? JSONDecoder().decode([Bookmark].self, from: data) {
        items = arr
    }
}
}
