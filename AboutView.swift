//
//  AboutView.swift
//  MushafBlue
//
//  Created by MOHAMMED ABDULLAH on 22/08/2025.
//


import SwiftUI

struct AboutView: View {
    var body: some View {
        Form {
            Section(header: Text("عن التطبيق")) {
                Text("تطبيق مصحف بسيط للقراءة والاستماع.")
            }
            Section(header: Text("الحقوق والمصادر")) {
                Text("النص القرآني: Tanzil.net — ترخيص CC BY-ND 3.0")
                Text("التلاوات: EveryAyah.com")
                Text("هذا التطبيق لا يجمع أي بيانات شخصية.")
            }
        }
        .navigationTitle("حول التطبيق")
    }
}
