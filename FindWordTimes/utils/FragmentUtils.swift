//
//  FragmentUtils.swift
//  MacAudioParser
//
//  Created by Stephen Astels on 2021-10-02.
//

import Foundation
import SwiftUI

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

func textForWords(_ fragments: [Fragment]) -> some View {
  return (
    HStack {
      ForEach(fragments, id: \.id) {
        Text($0.text).foregroundColor($0.color).padding(.leading, 8).padding(.trailing, 8)
          .border(Color.green)
      }
    }
  )
}
