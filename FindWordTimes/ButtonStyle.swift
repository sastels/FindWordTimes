//
//  ButtonStyle.swift
//  MacAudioParser
//
//  Created by Stephen Astels on 2021-10-02.
//

import Foundation
import SwiftUI

struct NiceButtonStyle: ButtonStyle {
  var foregroundColor: Color = .white
  var backgroundColor: Color = .blue
  var pressedColor: Color = .gray

  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .font(.headline)
      .padding(10)
      .foregroundColor(foregroundColor)
      .background(configuration.isPressed ? pressedColor : backgroundColor)
      .cornerRadius(5)
  }
}
