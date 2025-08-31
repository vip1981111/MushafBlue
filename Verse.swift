//
//  Verse.swift
//  MushafBlue
//
//  Created by MOHAMMED ABDULLAH on 21/08/2025.
//

import Foundation
struct Verse: Identifiable {
    let id = UUID()
    let sura: Int
    let aya: Int
    let text: String
}
