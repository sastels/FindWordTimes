//
//  PageView.swift
//  MacAudioParser
//
//  Created by Stephen Astels on 2021-10-02.
//

import Speech
import SwiftUI

struct PageView: View {
  @EnvironmentObject var book: Book
  @State var pageIndex: Int
  @State var url: URL
  @State var fragments: [Fragment] = []

  var body: some View {
    HStack(spacing: 8) {
      Button("Transcribe") {
        runRecognizer(url: url)
      }.buttonStyle(NiceButtonStyle())

      Button("Play colouring") {
        playSound(url)
        colorWords()
      }.buttonStyle(NiceButtonStyle())

      HStack {
        ForEach(fragments, id: \.id) {
          Text($0.text).foregroundColor($0.color).padding(.leading, 8).padding(.trailing, 8)
            .border(Color.green)
        }
      }
    }
  }

  func colorWords() {
    for (index, fragment) in fragments.enumerated() {
      Timer.scheduledTimer(withTimeInterval: fragment.startTime, repeats: false) { _ in
        fragments[index].color = .red
      }
      Timer.scheduledTimer(withTimeInterval: fragment.endTime, repeats: false) { _ in
        fragments[index].color = .white
      }
    }
  }

  func runRecognizer(url: URL) {
    SFSpeechRecognizer.requestAuthorization {
      authStatus in
      switch authStatus {
      case .authorized:
        let request = SFSpeechURLRecognitionRequest(url: url)
        SFSpeechRecognizer()?.recognitionTask(with: request) { result, _ in
          if let transcription = result?.bestTranscription {
            fragments.removeAll()
            book.pages[pageIndex].transcription.removeAll()
            for segment in transcription.segments {
              let newFragment = Fragment(text: segment.substring,
                                         startTime: segment.timestamp,
                                         endTime: segment.timestamp + segment.duration,
                                         color: .white)
              fragments.append(newFragment)
              book.pages[pageIndex].transcription.append(newFragment)
            }
          }
        }
      case .denied:
        print("Speech recognition authorization denied")
      case .restricted:
        print("Not available on this device")
      case .notDetermined:
        print("Not determined")
      @unknown default:
        print("Unknown error")
      }
    }
  }
}

struct PageView_Previews: PreviewProvider {
  static var previews: some View {
    PageView(pageIndex: 0, url: URL(fileURLWithPath: "")).environmentObject(Book())
  }
}
