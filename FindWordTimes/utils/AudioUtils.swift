//
//  AudioUtils.swift
//  MacAudioParser
//
//  Created by Stephen Astels on 2021-10-02.
//

import AVFoundation

var player: AVAudioPlayer?

func playSound(_ url: URL) {
  
//  guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else { return }
  do {
    player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
    guard let player = player else { return }
    player.play()
  } catch {
    print(error.localizedDescription)
  }
}
