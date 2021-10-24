//
//  BookText.swift
//  MacAudioParser
//
//  Created by Stephen Astels on 2021-10-02.
//

import SwiftUI

struct BookView: View {
  var urls: [URL]
  @State var pageIndex = 0

  var body: some View {
    return (
      VStack(spacing: 16) {
        HStack(spacing: 8) {
          ForEach(urls.indices, id: \.self) { page in
            Button("\(page)") {
              self.pageIndex = page
            }.buttonStyle(page == pageIndex ? CustomButtonStyle(.outline()) : CustomButtonStyle())
          }
        }
        if pageIndex < urls.count {
          PageView(pageIndex: pageIndex, url: urls[pageIndex])
        }
      }
    )
  }
}

struct BookView_Previews: PreviewProvider {
  static var previews: some View {
    BookView(urls: [])
  }
}
