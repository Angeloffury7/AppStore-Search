//
//  SearchResultView.swift
//  AppStoreSearch
//
//  Created by Mason Kim on 2023/08/24.
//

import SwiftUI

struct SearchResultView: View {
  @Binding var searchResults: [SearchResult]

  var body: some View {
    List(searchResults) { result in
      NavigationLink(value: result) {
        VStack {
          header(of: result)
          screenShotView(of: result)
        }
      }
      .buttonStyle(PlainButtonStyle())
      .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
  }

  private func header(of result: SearchResult) -> some View {
    HStack {
      AsyncImage(url: result.artworkUrl60)
        .cornerRadius(8)
        .frame(width: 64, height: 64)

      VStack(alignment: .leading, spacing: 4) {
        Text(result.trackName)
          .font(.body)
          .lineLimit(1)

        Text(result.genres.first ?? "")
          .font(.caption)
          .foregroundColor(.gray)
      }

      Spacer()

      Button {

      } label: {
        Text("받기")
          .foregroundColor(.blue)
          .fontWeight(.bold)
          .frame(width: 80, height: 32)
          .background(.gray.opacity(0.2))
          .cornerRadius(16)
      }

    }
  }

  private func screenShotView(of result: SearchResult) -> some View {
    let width = UIScreen.main.bounds.width
    let heigth = width / 3 * (21 / 9)
    return HStack {
      ForEach(result.screenshotUrls.prefix(3), id: \.self) {
        AsyncImage(url: $0) { image in
          image
            .resizable()
            .scaledToFit()
            .cornerRadius(8)
        } placeholder: {
          RoundedRectangle(cornerRadius: 8)
            .fill(.gray)
            .frame(height: heigth)
        }
      }
    }
    .frame(
      maxWidth: width,
      maxHeight: heigth
    )
    .padding(.horizontal)
  }
}

struct SearchResultView_Previews: PreviewProvider {
  static var previews: some View {
    SearchResultView(
      searchResults: .constant(SearchResponse.mock.results)
    )
  }
}
