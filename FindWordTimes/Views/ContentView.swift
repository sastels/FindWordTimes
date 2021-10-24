//
//  ContentView.swift
//  MacAudioParser
//
//  Created by Stephen Astels on 2021-10-02.
//

import Foundation
import SwiftUI
import SwiftyJSON

enum windowSize {
  // changes let to static - read comments
  static var minWidth: CGFloat = 1000
  static var minHeight: CGFloat = 500
  static var maxWidth: CGFloat = 2000
  static var maxHeight: CGFloat = 2500
}

struct ContentView: View {
  @EnvironmentObject var book: Book
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
          }.buttonStyle(CustomButtonStyle())
          Button("Print Metadata") {
            print(book)
          }.buttonStyle(CustomButtonStyle())
        }
        BookView(urls: urls).foregroundColor(.white)
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
        loadManualTimings()
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
      book.setUrls(urls)
    } catch {
      // failed to read directory – bad permissions, perhaps?
      print("getFiles fail, probably because of sandboxing")
      print("Error info: \(error)")
      urls = []
    }
  }

  // find the first json file in it and load that
  func loadManualTimings() {
    let fm = FileManager.default
    do {
      let jsonFiles = try fm.contentsOfDirectory(atPath: bookPath).filter { $0.hasSuffix(".json") }
      
      let jsonFile = "\(bookPath)/\(jsonFiles[0])"

      guard let jsonData: Data = try? String(contentsOfFile: jsonFile).data(using: .utf8) else { return }
      guard let json = try? JSON(data: jsonData) else { return }

      let pages = json["pages"].arrayObject as! [String]
      let timings = json["audio"]["f1"]
      let timingsDict = timings.dictionaryValue
      
      let keys = timingsDict.keys.sorted()
      
      for (index, (key, page)) in zip(keys, pages).enumerated() {
        let words = page.split(separator: " ")
        var wordStarts = timingsDict[key]?.arrayObject as! [Double]
        if wordStarts.isEmpty {
          wordStarts = words.map{_ in 0}
        }
        wordStarts.append(wordStarts.last! + 1)
        
        var fragments: [Fragment] = []
        for n in 0..<words.count {
          fragments.append(Fragment(text: String(words[n]), startTime: wordStarts[n], endTime: wordStarts[n+1]))
        }
        book.pages[index].manual = fragments
      }
      
      
    } catch {
      // couldn't find json file
      print("Couldn't find json file in \(bookPath)")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView().environmentObject(Book())
  }
}
