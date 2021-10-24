//
//  Book.swift
//  FindWordTimes
//
//  Created by Stephen Astels on 2021-10-17.
//

import Foundation
import SwiftUI

class Book: ObservableObject, CustomStringConvertible {
   @Published var pages: [Sentence] = []
  
  var description: String {
    var retVal = ""
    for (index, page) in pages.enumerated() {
      retVal += "Page \(index):\n\(page)\n"
    }
    return retVal
  }
  
  func setUrls(_ urls: [URL]) {
    pages = []
    for url in urls {
      pages.append(Sentence(url: url))
    }
  }
}

class Sentence: ObservableObject, CustomStringConvertible {
  @Published var apple: [Fragment] = []
  @Published var google: [Fragment] = []
  @Published var manual: [Fragment] = []
  @Published var audioUrl: URL
  
  init(url: URL) {
    audioUrl = url
  }
  
  var description: String {
    return manual.reduce("", {text, fragment in text + "\(fragment)\n"})
  }
}

struct Fragment: CustomStringConvertible {
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
  
  var description: String {
      return "\(text) (\(startTime), \(endTime))"
  }
}
