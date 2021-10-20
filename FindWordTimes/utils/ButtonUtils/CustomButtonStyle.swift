//
//  CustomButtonStyle.swift
//  SwiftUIButtons
//
//  Created by Stephen Astels on 2021-09-18.
//
// based on https://betterprogramming.pub/build-your-own-button-component-library-from-scratch-in-swiftui-14cfa2f0036b

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
  private var display: DisplayStyle
  private var font: Font
  private var isFullWidth: Bool
  private var verticalPadding: CGFloat
  private var horizontalPadding: CGFloat

  init(_ display: DisplayStyle = .default(type: .primary),
       size: Size = .default,
       isFullWidth: Bool = false,
       verticalPadding: CGFloat = 4,
       horizontalPadding: CGFloat = 16
       )
  {
    self.display = display
    font = size.getFont()
    self.isFullWidth = isFullWidth
    self.verticalPadding = verticalPadding
    self.horizontalPadding = horizontalPadding
  }

  func makeBody(configuration: Self.Configuration) -> some View {
    
    return configuration.label
      .applyModifier(if: isFullWidth, FullWidthModifier())
      .padding(.vertical, verticalPadding)
      .padding(.horizontal, horizontalPadding)
      .font(font)
      .background(display.backgroundColor)
      .foregroundColor(display.foregroundColor)
      .cornerRadius(display.cornerRadius)
      .opacity(configuration.isPressed ? 0.7 : 1)
      .shadow(color: display.backgroundColor!.opacity(0.2),
              radius: display.cornerRadius,
              x: 0,
              y: 5)
      .overlay(
        RoundedRectangle(cornerRadius: display.cornerRadius)
          .stroke(display.borderColor, lineWidth: 1)
      )
      .scaleEffect(configuration.isPressed ? 0.8 : 1)
      .animation(.easeInOut(duration: 0.2))
  }
}
