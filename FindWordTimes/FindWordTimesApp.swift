//
//  FindWordTimesApp.swift
//  FindWordTimes
//
//  Created by Stephen Astels on 2021-10-16.
//

import SwiftUI

@main
struct FindWordTimesApp: App {
  @StateObject var book = Book()
  var body: some Scene {
    WindowGroup {
      ContentView().environmentObject(book)
    }
  }
}
