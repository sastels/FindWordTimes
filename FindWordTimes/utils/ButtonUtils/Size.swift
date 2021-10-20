//
//  Size.swift
//  SwiftUIButtons
//
//  Created by Stephen Astels on 2021-09-18.
//

import SwiftUI

enum Size {
  case `default`, small, large

  func getFont() -> Font {
    switch self {
    case .small:
      return Font.caption
    case .large:
      return Font.title
    default:
      return Font.body
    }
  }
}

struct FullWidthModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity)
  }
}

public extension View {
  // If condition is met, apply modifier, otherwise, leave the view untouched
  func applyModifier<T>(if condition: Bool, _ modifier: T) -> some View where T: ViewModifier {
    Group {
      if condition {
        self.modifier(modifier)
      } else {
        self
      }
    }
  }
}
