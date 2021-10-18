//
//  FragmentUtils.swift
//  MacAudioParser
//
//  Created by Stephen Astels on 2021-10-02.
//

import Foundation
import SwiftUI

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
