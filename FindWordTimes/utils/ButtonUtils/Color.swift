//
//  AccentColored.swift
//  SwiftUIButtons
//
//  Created by Stephen Astels on 2021-09-18.
//

import SwiftUI

protocol AccentColoured {
  static var primaryColor: Color? { get }
  static var secondaryColor: Color? { get }
}

extension AccentColoured {
  static var secondaryColor: Color? {
    Color.white
  }
}

struct PrimaryStyleConfig: AccentColoured {
  static var primaryColor: Color? {
    Color.blue
  }
}

struct SuccessStyleConfig: AccentColoured {
  static var primaryColor: Color? {
    Color.green
  }
}

struct InfoStyleConfig: AccentColoured {
  static var primaryColor: Color? {
    return Color.blue.opacity(0.6)
  }
}

struct LightStyleConfig: AccentColoured {
  static var primaryColor: Color? {
    return Color.gray.opacity(0.2)
  }

  static var secondaryColor: Color? {
    Color.blue
  }
}

struct WarningStyleConfig: AccentColoured {
  static var primaryColor: Color? {
    return Color.orange
  }
}

struct DangerStyleConfig: AccentColoured {
  static var primaryColor: Color? {
    return Color.red
  }
}

struct DarkStyleConfig: AccentColoured {
  static var primaryColor: Color? {
    return Color.black
  }
}

enum ButtonStyles {
  case primary, light, success, info, warning, danger, dark

  var secondaryColor: Color? {
    switch self {
    case .light:
      return LightStyleConfig.secondaryColor

    case .primary:
      return PrimaryStyleConfig.secondaryColor

    default:
      return Color.white
    }
  }

  var primaryColor: Color? {
    switch self {
    case .primary:
      return PrimaryStyleConfig.primaryColor

    case .light:
      return LightStyleConfig.primaryColor

    case .success:
      return SuccessStyleConfig.primaryColor

    case .info:
      return InfoStyleConfig.primaryColor

    case .warning:
      return WarningStyleConfig.primaryColor

    case .danger:
      return DangerStyleConfig.primaryColor

    case .dark:
      return DarkStyleConfig.primaryColor
    }
  }
}
