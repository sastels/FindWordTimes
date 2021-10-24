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
  var pageIndex: Int

  var url: URL
  @State var apple: [Fragment] = []
  @State var google: [Fragment] = []

  var body: some View {
    return (
      VStack(spacing: 8) {
        HStack(spacing: 8) {
          Button("Transcribe \(pageIndex)") {
            print("recognize \(url)")
            runRecognizer(url: url)
          }.buttonStyle(CustomButtonStyle(.rounded(type: .light)))
          Button("Play colouring") {
            playSound(url)
            colorAppleFragments()
            colorGoogleFragments()
          }.buttonStyle(CustomButtonStyle(.rounded(type: .light)))
        }
        VStack {
          textForFragments(apple)
          textForFragments(google)
        }
      }
    )
  }

  func textForFragments(_ fragments: [Fragment]) -> some View {
    return fragments.reduce(Text("")) { text, fragment in
      text +
        Text(fragment.text)
        .foregroundColor(fragment.color)
        + Text(" | ")
    }
  }

//      return words.reduce(Text("")) {
//        $0
//          + Text($1[0]).foregroundColor($1[1] == "red" ? .red : .black)
//          + Text(" ")
//      }
//    }

  func sentenceButtons(_ fragments: [Fragment]) -> some View {
    HStack {
      ForEach(fragments, id: \.id) { fragment in
        Button(fragment.text) {
          print(fragment.text)
        }.buttonStyle(fragment.color == .white ?
          CustomButtonStyle() : CustomButtonStyle(.default(type: .success)))
      }
    }
  }

  func colorAppleFragments() {
    for (index, fragment) in apple.enumerated() {
      Timer.scheduledTimer(withTimeInterval: fragment.startTime, repeats: false) { _ in
        apple[index].color = .red
      }
      Timer.scheduledTimer(withTimeInterval: fragment.endTime, repeats: false) { _ in
        apple[index].color = .white
      }
    }
  }
  
  func colorGoogleFragments() {
    for (index, fragment) in google.enumerated() {
      Timer.scheduledTimer(withTimeInterval: fragment.startTime, repeats: false) { _ in
        google[index].color = .red
      }
      Timer.scheduledTimer(withTimeInterval: fragment.endTime, repeats: false) { _ in
        google[index].color = .white
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
            apple.removeAll()
            book.pages[pageIndex].apple.removeAll()
            for segment in transcription.segments {
              let newFragment = Fragment(text: segment.substring,
                                         startTime: segment.timestamp,
                                         endTime: segment.timestamp + segment.duration,
                                         color: .white)
              apple.append(newFragment)
              book.pages[pageIndex].apple.append(newFragment)
            }
            google = Array(apple[1...])
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
