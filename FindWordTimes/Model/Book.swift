//
//  Book.swift
//  FindWordTimes
//
//  Created by Stephen Astels on 2021-10-17.
//

import Foundation
import SwiftUI

class Book: ObservableObject {
   @Published var pages: [Sentence] = []
  
  func setUrls(_ urls: [URL]) {
    pages = []
    for url in urls {
      pages.append(Sentence(url: url))
    }
  }
}

class Sentence: ObservableObject {
  @Published var transcription: [Fragment] = []
  @Published var actual: [String] = []
  @Published var audioUrl: URL
  
  init(url: URL) {
    audioUrl = url
  }
}

struct Fragment {
  let id = UUID()
  var text: String = ""
  var startTime: TimeInterval = 0.0
  var endTime: TimeInterval = 0.0
  var color: Color = .white

  init(text: String = "", startTime: TimeInterval = 0.0, endTime: TimeInterval = 0.0, color: Color = .white) {
    self.text = text
    self.startTime = startTime
    self.endTime = endTime
    self.color = color
  }
}
