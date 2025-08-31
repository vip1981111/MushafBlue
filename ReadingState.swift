//
//  ReadingState.swift
//  MushafBlue
//
//  Created by MOHAMMED ABDULLAH on 22/08/2025.
//

import Foundation

struct ReadingState {
    static let shared = ReadingState()
    private let keySura = "lastSura"
    private let keyAya = "lastAya"
func save(sura: Int, aya: Int) {
    UserDefaults.standard.set(sura, forKey: keySura)
    UserDefaults.standard.set(aya, forKey: keyAya)
}

func load() -> (sura: Int, aya: Int)? {
    let s = UserDefaults.standard.integer(forKey: keySura)
    let a = UserDefaults.standard.integer(forKey: keyAya)
    if s > 0 && a > 0 { return (s, a) }
    return nil
}
}
