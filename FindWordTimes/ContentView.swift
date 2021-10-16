//
//  ContentView.swift
//  MacAudioParser
//
//  Created by Stephen Astels on 2021-10-02.
//

import Foundation
import SwiftUI

enum windowSize {
  // changes let to static - read comments
  static var minWidth: CGFloat = 1000
  static var minHeight: CGFloat = 500
  static var maxWidth: CGFloat = 2000
  static var maxHeight: CGFloat = 2500
}

struct ContentView: View {
  @State var bookPath: String = ""
  @State var urls: [URL] = [] {
    didSet {
      print("didSet urls \(urls)")
    }
  }

  var body: some View {
    return (
      VStack(spacing: 16) {
        Text("book: \(bookPath)")
        HStack(spacing: 16) {
          Button("Choose Book") {
            openBook()
          }.buttonStyle(NiceButtonStyle())
        }
        BookText(urls: urls).foregroundColor(.white)
          .frame(minWidth: windowSize.minWidth, minHeight: windowSize.minHeight)
          .frame(maxWidth: windowSize.maxWidth, maxHeight: windowSize.maxHeight)
        Spacer()
      }.font(.title).padding()
    )
  }

  func openBook() {
    let dialog = NSOpenPanel()
    dialog.title = "Choose a Book Directory"
    dialog.canChooseDirectories = true
    dialog.canChooseFiles = false
    dialog.showsResizeIndicator = true
    dialog.showsHiddenFiles = false
    dialog.allowsMultipleSelection = false

    if dialog.runModal() == NSApplication.ModalResponse.OK {
      let result = dialog.url // Pathname of the file

      if result != nil {
        let path: String = result!.path
        print("Book: \(path)")
        bookPath = path
        UserDefaults.standard.set(bookPath, forKey: "bookPath")
        getFiles()
      }
    } else {
      // User clicked on "Cancel"
      return
    }
  }

  func getFiles() {
    let fm = FileManager.default
    print("GetFiles bookPath: <\(bookPath)>")

    do {
      let items = try fm.contentsOfDirectory(atPath: bookPath).filter { $0.hasSuffix(".mp3") }
      urls = items.sorted().map { URL(fileURLWithPath: "\(bookPath)/\($0)") }

      print("getFiles \(urls)")
    } catch {
      // failed to read directory – bad permissions, perhaps?
      print("getFiles fail, probably because of sandboxing")
      print("Error info: \(error)")
      urls = []
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
