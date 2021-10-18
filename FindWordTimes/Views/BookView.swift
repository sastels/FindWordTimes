//
//  BookText.swift
//  MacAudioParser
//
//  Created by Stephen Astels on 2021-10-02.
//

import SwiftUI

struct BookView: View {
  var urls: [URL]

  var body: some View {
    return (
      VStack(alignment: .leading, spacing: 16) {
        Text("\(urls.count) pages").frame(minWidth: 500, minHeight: 200)
        ForEach(Array(zip(urls.indices, urls)), id: \.0) { pageIndex, url in
          PageView(pageIndex: pageIndex, url: url)
        }
      }.onAppear {
        print("urls: \(urls)")
      }
    )
  }
}

struct BookView_Previews: PreviewProvider {
  static var previews: some View {
    BookView(urls: [])
  }
}
