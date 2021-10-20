//
//  DisplayStyle.swift
//  SwiftUIButtons
//
//  Created by Stephen Astels on 2021-09-18.
//

import SwiftUI

enum DisplayStyle: ButtonStyleConfig {
  case `default`(type: ButtonStyles = .primary)
  case transparent(type: ButtonStyles = .primary)
  case outline(type: ButtonStyles = .primary)
  case rounded(type: ButtonStyles = .primary)
    
  var foregroundColor: Color? {
    switch self {
    case .default(let type):
      return type.secondaryColor
            
    case .transparent(let type):
      return type.primaryColor
            
    case .outline(let type):
      return type.primaryColor
            
    case .rounded(let type):
      return type.secondaryColor
    }
  }
    
  var backgroundColor: Color? {
    switch self {
    case .default(let type):
      return type.primaryColor
            
    case .transparent:
      return .white.opacity(0.0)
            
    case .outline(let type):
      return type.secondaryColor
            
    case .rounded(let type):
      return type.primaryColor
    }
  }
    
  var borderColor: Color {
    if case .outline(let type) = self {
      return type.primaryColor ?? Color.clear
    }
        
    return Color.clear
  }
    
  var cornerRadius: CGFloat {
    if case .rounded = self {
      return 40
    }
        
    return 6
  }
}

protocol ButtonStyleConfig {
  var foregroundColor: Color? { get }
  var backgroundColor: Color? { get }
  var borderColor: Color { get }
  var borderWidth: CGFloat { get }
  var cornerRadius: CGFloat { get }
}

extension ButtonStyleConfig {
  var borderColor: Color {
    Color.clear
  }

  var borderWidth: CGFloat {
    0
  }

  var cornerRadius: CGFloat {
    6
  }
}
