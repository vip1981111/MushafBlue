//
//  ArabicDigits.swift
//  MushafBlue
//
//  Created by MOHAMMED ABDULLAH on 22/08/2025.
//

import Foundation
extension Int {
    var arabicDigits: String {
        let f = NumberFormatter()
        f.locale = Locale(identifier: "ar")
        return f.string(from: NSNumber(value: self)) ?? "(self)"
    }
}

func ayahBadge(_ n: Int) -> String {
    "﴿(n.arabicDigits)﴾"
}
