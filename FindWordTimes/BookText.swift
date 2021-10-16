//
//  BookText.swift
//  MacAudioParser
//
//  Created by Stephen Astels on 2021-10-02.
//

import SwiftUI

struct BookText: View {
  var urls: [URL]

  var body: some View {
    return (
      VStack(alignment: .leading, spacing: 16) {
        Text("\(urls.count) pages").frame(minWidth: 500, minHeight: 200)
        ForEach(urls, id: \.self) {
          SentenceRow(url: $0)
        }
      }.onAppear {
        print("urls: \(urls)")
      }
    )
  }
}

struct BookText_Previews: PreviewProvider {
  static var previews: some View {
    BookText(urls: [])
  }
}
