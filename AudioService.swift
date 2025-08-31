//
//  AudioService.swift
//  MushafBlue
//
//  Created by MOHAMMED ABDULLAH on 21/08/2025.
//

import Foundation
import AVFoundation

final class AudioService: ObservableObject {
    static let shared = AudioService()
    private let reciterFolder = "Abdul_Basit_Murattal_192kbps"
    private var player: AVPlayer?
    @Published var currentlyPlayingKey: String?
    var onItemFinished: ((Int, Int) -> Void)?
    
    private init() {
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)
    }
    
    private func urlFor(sura: Int, aya: Int) -> URL {
        URL(string: "https://everyayah.com/data/\(reciterFolder)/\(String(format:"%03d",sura))\(String(format:"%03d",aya)).mp3")!
    }
    
    func play(sura: Int, aya: Int) {
        let key = "\(sura)-\(aya)"
        let item = AVPlayerItem(url: urlFor(sura: sura, aya: aya))
        if player == nil { player = AVPlayer() }
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(itemDidEnd),
                                               name: .AVPlayerItemDidPlayToEndTime, object: item)
        player?.replaceCurrentItem(with: item)
        DispatchQueue.main.async { [weak self] in
            self?.currentlyPlayingKey = key
            self?.player?.play()
        }
    }
    
    @objc private func itemDidEnd() {
        // اقرأ المفتاح قبل التصفير
        let key = currentlyPlayingKey
        if let k = key {
            let parts = k.split(separator: "-")
            if parts.count == 2, let s = Int(parts[0]), let a = Int(parts[1]) {
                DispatchQueue.main.async { [weak self] in
                    self?.onItemFinished?(s, a)
                    self?.currentlyPlayingKey = nil
                }
            }
        } else {
            DispatchQueue.main.async { [weak self] in self?.currentlyPlayingKey = nil }
        }
    }
    
    func pause() {
        player?.pause()
        DispatchQueue.main.async { [weak self] in self?.currentlyPlayingKey = nil }
    }
    
    func toggle(sura: Int, aya: Int) {
        let key = "\(sura)-\(aya)"
        if currentlyPlayingKey == key {
            pause()
        } else {
            play(sura: sura, aya: aya)
        }
    }
}
