//
//  SearchView.swift
//  AppStoreSearch
//
//  Created by Mason Kim on 2023/08/24.
//

import SwiftUI
import Core

struct SearchView: View {
  @State private var searchText = ""

  @EnvironmentObject var store: StoreOf<SearchReducer>

  var body: some View {
    NavigationStack {
      showingList
        .navigationTitle("검색")
        .navigationDestination(for: SearchResult.self) { result in
          AppDetailView(result: result)
        }
    }
    .searchable(
      text: $searchText,
      placement: .navigationBarDrawer(displayMode: .always),
      prompt: "App Store"
    )
    .searchSuggestions {
      if store.state.showingState == .searching {
        suggestionView
      }
    }
    .onSubmit(of: .search) {
      store.dispatch(.search(keyword: searchText))
    }
    .onChange(of: searchText) { searchText in
      store.dispatch(.change(keyword: searchText))
    }
    .onAppear {
      store.dispatch(.onAppear)
    }
  }

  @ViewBuilder
  private var showingList: some View {
    switch store.state.showingState {
    case .searching:
      recentSearchList
    case .showingResult:
      SearchResultView(
        results: store.state.searchResults
      )
    case .loading:
      EmptyView()
    case .showingError:
      EmptyView()
    }
  }

  private var recentSearchList: some View {
    Section {
      List(store.state.histories, id: \.self) { data in
        Button {
          searchText = data
          store.dispatch(.search(keyword: data))
        } label: {
          Text(data)
            .foregroundColor(.blue)
            .font(.title3)
        }
      }
      .listStyle(.plain)
    } header: {
      recentSearchTitle
    }
  }

  private var recentSearchTitle: some View {
    Text("최근 검색어")
      .font(.title2)
      .fontWeight(.bold)
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(.horizontal)
      .padding(.top)
  }

  private var suggestionView: some View {
    ForEach(store.state.suggestions, id: \.self) { suggestion in
      HStack(spacing: 0) {
        Text("")  // Image가 가장 앞에 있으면 Divider가 살짝 잘리는 이슈 때문에 추가함.

        Image(systemName: "magnifyingglass")
          .padding(.trailing, 8)
        Text(suggestion)
      }
      .onTapGesture {
        store.dispatch(.select(suggestion: suggestion))
      }
    }
    .listStyle(.plain)
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchView()
      .environmentObject(
        Store(reducer: SearchReducer(
          searchService: SearchService(
            router: NetworkRouter()
          ),
          historyService: HistoryService()
        ))
      )
  }
}

